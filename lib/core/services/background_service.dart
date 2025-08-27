import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:logger/logger.dart';
import 'package:waslny_pusher_test_driver/core/services/pusher_initializer.dart';

final logger = Logger();

@pragma('vm:entry-point')
Future<void> initializeService() async {
  logger.i('Initializing background service');
  final service = FlutterBackgroundService();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'my_foreground',
        channelName: 'MY FOREGROUND SERVICE',
        channelDescription: 'Keeps the service alive',
        importance: NotificationImportance.High,
        playSound: false,
        enableVibration: false,
      )
    ],
  );

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      autoStartOnBoot: true,
      autoStart: true,
      onStart: onStart,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
      
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
  logger.i('Background service started');
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  logger.i('onIosBackground');
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  logger.i('onStart');
  DartPluginRegistrant.ensureInitialized();

  service.on('stopService').listen((event) {
    logger.i('Stopping service');
    service.stopSelf();
  });

  // Old implementation
  // logger.i('Initializing PusherController');
  // final pusherInitializer =
  //     PusherInitializer("103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669");
  // pusherInitializer.initPusherAndSync();
  // try {} catch (e) {
  //   print("ERROR: $e");
  // }
  // New implementation
  final pusherInitializer = PusherInitializer(
      "103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669", service);
  pusherInitializer.initPusherAndSync();
  Timer.periodic(const Duration(seconds: 1), (timer) {
    // Keep the service alive
  });
}
