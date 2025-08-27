import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/models/account_suspension.dart';
import 'package:waslny_pusher_test_driver/core/models/notification.dart'
    as app_notification;

class AccountSuspendedHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final decodedData = jsonDecode(data);
    final suspension = AccountSuspension.fromJson(decodedData['suspension']);
    final notification =
        app_notification.Notification.fromJson(decodedData['notification']);
    print('====== ACCOUNT SUSPENDED ======');
    print('Suspension ID: ${suspension.id}');
    print('Reason: ${suspension.suspension.reason}');
    print('Notification Title: ${notification.title}');
    print('Notification Body: ${notification.body}');
    print('=============================');
  }
}
