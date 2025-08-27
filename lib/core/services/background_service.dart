import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/pusher_controller.dart';

final logger = Logger();

@pragma('vm:entry-point')
Future<void> initializeService() async {
  logger.i('Initializing background service');
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      autoStartOnBoot: true,
      autoStart: true,
      onStart: onStart,
      isForegroundMode: true,
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
  // final pusherController =
  //     PusherController("103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669");
  // pusherController.initPusherAndSync();
  // try {} catch (e) {
  //   print("ERROR: $e");
  // }
  // New implementation
  final pusherController =
      PusherController("103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669");
  InternetConnection().onStatusChange.listen((InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        logger.i('Data connection is available.');
        pusherController.initPusherAndSync();
        break;
      case InternetStatus.disconnected:
        logger.e('Data connection is not available.');
        break;
    }
  });
  Timer.periodic(const Duration(seconds: 1), (timer) {
    // Keep the service alive
  });
}
