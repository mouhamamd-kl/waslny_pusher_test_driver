import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:waslny_pusher_test_driver/core/models/notification.dart'
    as app_notification;
import 'package:waslny_pusher_test_driver/core/services/notification_service.dart';

class NotificationHandler {
  void handle(dynamic data) {
    final NotificationService notificationService = NotificationService();
    final logger = Logger();
    final decodedData = jsonDecode(data);
    logger.e(decodedData);
    try {
      final notification =
          app_notification.Notification.fromJson(decodedData['notification']);
      notificationService.showNotification(
        title: notification.title,
        body: notification.body,
      );
      print('====== TRIP TIME NEAR ======');
      print('Notification Title: ${notification.title}');
      print('Notification Body: ${notification.body}');
      print('============================');
    } catch (e) {
      logger.e(e);
    }
  }
}
