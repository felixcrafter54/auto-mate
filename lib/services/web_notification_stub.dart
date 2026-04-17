/// Stub used on non-web platforms. The real implementation lives in
/// `web_notification_web.dart` and is selected via conditional imports.
class WebNotificationApi {
  static String get permission => 'denied';
  static Future<String> requestPermission() async => 'denied';
  static void show(String title, String body) {}
}
