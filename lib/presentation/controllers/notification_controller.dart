import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:waslny_pusher_test_driver/core/services/background_service.dart';

class NotificationController {
  @pragma('vm:entry-point')
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      initializeNotificationChannels(),
      channelGroups: initializeNotificationGroups(),
      debug: true,
    );
  }

  @pragma('vm:entry-point')
  static List<NotificationChannelGroup>? initializeNotificationGroups() {
    List<NotificationChannelGroup> groups = [];
    groups.addAll(
      [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
    );
    return groups;
  }

  @pragma('vm:entry-point')
  static List<NotificationChannel> initializeNotificationChannels() {
    List<NotificationChannel> channels = [];
    channels.addAll(
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color.fromARGB(255, 38, 38, 208),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
          soundSource: 'resource://raw/pikachu',
        ),
      ],
    );
    return channels;
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  @pragma('vm:entry-point')
  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    Random random = Random();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: random.nextInt(999),
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        color: const Color.fromARGB(255, 86, 54, 244),
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      // actionButtons: actionButtons,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> showNotificationJson(Map<String, dynamic> data) async {
    Logger logger = Logger();
    try {
      //The old implementation
      // await AwesomeNotifications().createNotification(
      //   content: NotificationContent(
      //     id: int.parse(data["id"]),
      //     channelKey: 'high_importance_channel',
      //     title: data["title"],
      //     body: data["body"],
      //     payload: Map.from(data["payload"]) ?? null,
      //     wakeUpScreen: true,
      //     displayOnBackground: true,
      //     displayOnForeground: true,
      //   ),
      // );
      // await AwesomeNotifications().createNotificationFromJsonData(data);
      //The new implementation

      if ((data['payload'] is String) == false) {
        data['payload'] = jsonDecode(data['payload']);
      }

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: int.parse(data["id"]),
          channelKey: 'high_importance_channel',
          title: data["title"],
          body: data["body"],
          // payload: data["payload"],
          wakeUpScreen: true,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
      );
    } catch (e) {
      logger.e(e);
    }
  }
}
