import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  void onForegroundNotification(
    String title, String body, FlutterLocalNotificationsPlugin localNotificationsPlugin
  ) async {
    IOSNotificationDetails iosDetails = IOSNotificationDetails();
    NotificationDetails notiDetails = NotificationDetails(
      iOS: iosDetails
    );
    await localNotificationsPlugin.show(
      Random().nextInt(1000),
      title,
      body,
      notiDetails,
    );
  }
}