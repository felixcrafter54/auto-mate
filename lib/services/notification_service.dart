import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'web_notification_stub.dart'
    if (dart.library.html) 'web_notification_web.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;
  static final Map<int, Timer> _webTimers = {};

  static bool get _isLinux =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  Future<void> init() async {
    if (_initialized) return;
    if (kIsWeb) {
      _initialized = true;
      return;
    }

    tzdata.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const linuxSettings =
        LinuxInitializationSettings(defaultActionName: 'Open AutoMate');

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
        linux: linuxSettings,
      ),
    );
    _initialized = true;
  }

  Future<bool> hasPermission() async {
    if (kIsWeb) {
      return WebNotificationApi.permission == 'granted';
    }
    if (_isLinux) return true;
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<bool> requestPermission() async {
    if (kIsWeb) {
      if (WebNotificationApi.permission == 'granted') return true;
      if (WebNotificationApi.permission == 'denied') return false;
      final result = await WebNotificationApi.requestPermission();
      return result == 'granted';
    }
    if (_isLinux) return true;
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<void> openSystemSettings() async {
    if (kIsWeb || _isLinux) return;
    await openAppSettings();
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    if (kIsWeb) {
      _scheduleWeb(id: id, title: title, body: body, when: when);
      return;
    }
    // libnotify (Linux) doesn't support scheduled notifications
    if (_isLinux) return;
    await init();
    final delay = when.difference(DateTime.now());
    if (delay.isNegative) return;

    const android = AndroidNotificationDetails(
      'automate_reminders',
      'Wartungs-Erinnerungen',
      channelDescription: 'Erinnerungen für Ölwechsel, TÜV, Inspektionen …',
      importance: Importance.high,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);

    // Schedule relative to UTC "now" so the result is correct even if
    // `tz.local` hasn't been configured (it defaults to UTC after
    // `initializeTimeZones()` — using it with a local DateTime misinterprets
    // the fields and pushes the alarm by the timezone offset).
    final zoned = tz.TZDateTime.now(tz.UTC).add(delay);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      zoned,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNow({
    required int id,
    required String title,
    required String body,
  }) async {
    if (kIsWeb) {
      _showWebNotification(title, body);
      return;
    }
    await init();
    const android = AndroidNotificationDetails(
      'automate_reminders',
      'Wartungs-Erinnerungen',
      channelDescription: 'Erinnerungen für Ölwechsel, TÜV, Inspektionen …',
      importance: Importance.high,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const linux = LinuxNotificationDetails();
    const details =
        NotificationDetails(android: android, iOS: ios, linux: linux);
    await _plugin.show(id, title, body, details);
  }

  Future<void> cancel(int id) async {
    if (kIsWeb) {
      _webTimers.remove(id)?.cancel();
      return;
    }
    try {
      await init();
      await _plugin.cancel(id);
    } catch (_) {
      // Swallow — canceling a non-existent / uninitialized alarm must never
      // block callers (e.g. deleting a reminder should succeed even if the
      // alarm was never scheduled).
    }
  }

  // ==========================================================================
  // WEB IMPLEMENTATION
  // ==========================================================================

  void _scheduleWeb({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) {
    if (WebNotificationApi.permission != 'granted') return;

    final now = DateTime.now();
    final delay = when.difference(now);

    if (delay.isNegative) return;

    // Timer supports up to ~24 days on the web (setTimeout 32-bit limit).
    // Anything further out is skipped — the native app covers long-range
    // scheduling; for web we'd need FCM/push to fire reliably.
    if (delay.inDays > 24) return;

    _webTimers.remove(id)?.cancel();
    _webTimers[id] = Timer(delay, () {
      _showWebNotification(title, body);
      _webTimers.remove(id);
    });
  }

  void _showWebNotification(String title, String body) {
    if (WebNotificationApi.permission != 'granted') return;
    WebNotificationApi.show(title, body);
  }
}
