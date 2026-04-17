import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Thin wrapper around the browser Notification API.
class WebNotificationApi {
  static String get permission => web.Notification.permission;

  static Future<String> requestPermission() async {
    final result = await web.Notification.requestPermission().toDart;
    return result.toDart;
  }

  static void show(String title, String body) {
    web.Notification(title, web.NotificationOptions(body: body));
  }
}
