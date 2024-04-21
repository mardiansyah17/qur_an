import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));
  }

  static Future<void> show({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      importance: Importance.max,
    );
    const platform = NotificationDetails(android: android);
    await _notification.show(0, title, body, platform);
  }
}
