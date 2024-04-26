import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();
  static const android = AndroidNotificationDetails(
    'channel id',
    'channel name',
    importance: Importance.max,
  );

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));
  }

  static Future<void> show({
    required String title,
    required String body,
  }) async {
    const platform = NotificationDetails(android: android);
    try {
      await _notification.show(0, title, body, platform);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> scheduleNotification(
      DateTime scheduledTime, String title, String body) async {
    const platformChannelSpecifics = NotificationDetails(android: android);

    try {
      await _notification.zonedSchedule(
        1, // ID notifikasi (dapat diganti dengan ID unik)
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (err) {
      print(err);
    }
  }
}
