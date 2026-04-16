import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Lightweight wrapper around flutter_local_notifications.
/// On web all operations are no-ops (Web Notifications need different plumbing).
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  Future<void> init() async {
    if (_initialized || kIsWeb) {
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

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );
    _initialized = true;
  }

  /// Returns true if the user has already granted notification permission.
  Future<bool> hasPermission() async {
    if (kIsWeb) return false;
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  /// Requests notification permission. Returns true if granted.
  /// Shows the native OS dialog on Android 13+ and iOS.
  Future<bool> requestPermission() async {
    if (kIsWeb) return false;
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Opens the app's system settings page so the user can grant permission
  /// after previously denying it.
  Future<void> openSystemSettings() async {
    if (kIsWeb) return;
    await openAppSettings();
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    if (kIsWeb) return;
    await init();
    if (when.isBefore(DateTime.now())) return;

    const android = AndroidNotificationDetails(
      'automate_reminders',
      'Wartungs-Erinnerungen',
      channelDescription: 'Erinnerungen für Ölwechsel, TÜV, Inspektionen …',
      importance: Importance.high,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(when, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancel(int id) async {
    if (kIsWeb) return;
    await init();
    await _plugin.cancel(id);
  }
}
