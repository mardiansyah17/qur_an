import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:qur_an/utils/contants.dart';

class NotificationHelper {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/logo_sahabat_muslim',
        // null,
        [
          NotificationChannel(
              channelKey: 'sholat',
              channelName: 'Waktu sholat',
              channelDescription: 'Waktu sholat',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.red,
              soundSource: 'resource://raw/adzan',
              ledColor: Colors.deepPurple),
          NotificationChannel(
              channelGroupKey: 'sound_tests',
              channelKey: "custom_sound",
              channelName: "Custom sound notifications",
              channelDescription: "Notifications with custom sound",
              playSound: true,
              soundSource: 'resource://raw/adzan',
              defaultColor: Colors.red,
              ledColor: Colors.red,
              vibrationPattern: lowVibrationPattern)
        ],
        debug: Constants.isDebug);
  }

  static Future<void> createNewNotification() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'sholat',
          title: 'Huston! The eagle has landed!',

          body:
              "A small step for a man, but a giant leap to Flutter's community!",

          //'asset://assets/images/balloons-in-sky.jpg',
          notificationLayout: NotificationLayout.BigPicture,
        ),
        actionButtons: [
          NotificationActionButton(key: 'stop', label: 'Stop'),
        ]);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction event) async {
    switch (event.buttonKeyPressed) {
      case "stop":
        print(event);
        // AwesomeNotifications().cancel(id);
        break;
      default:
    }
  }

  static Future<void> startListeningNotificationEvents() async {
    await AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  static Future<bool> scheduleNotification(
      DateTime scheduledTime, String title, String body) async {
    return await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, channelKey: "sholat", title: title, body: body),
        schedule: NotificationCalendar(
            day: scheduledTime.day,
            month: scheduledTime.month,
            year: scheduledTime.year,
            minute: scheduledTime.minute,
            hour: scheduledTime.hour));
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
