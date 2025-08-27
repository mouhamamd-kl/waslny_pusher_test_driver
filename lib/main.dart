import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waslny_pusher_test_driver/core/services/background_service.dart';
import 'package:waslny_pusher_test_driver/core/services/notification_service.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/driver_controller.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/pusher_controller.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/home_screen.dart';
import 'package:waslny_pusher_test_driver/core/services/lifecycle_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    debug: true,
  );
  // final pusherController =
  //     PusherController("103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669");
  // pusherController.initPusherAndSync();
  await initializeService();
  Get.lazyPut(() => DriverController());
  WidgetsBinding.instance.addObserver(LifecycleManager());
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  if (await Permission.location.isDenied) {
    await Permission.location.request();
  }
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
  if (await Permission.accessNotificationPolicy.isDenied) {
    await Permission.accessNotificationPolicy.request();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationService.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationService.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationService.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationService.onDismissActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Waslny',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
