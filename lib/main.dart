import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waslny_pusher_test_driver/core/services/fcm_service.dart';
import 'package:waslny_pusher_test_driver/core/services/fcm_notification_service.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/driver_controller.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/notification_controller.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/pusher_controller.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/home_screen.dart';
import 'package:waslny_pusher_test_driver/core/services/lifecycle_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _requestPermissions();
  final pusherController =
      PusherController("103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669");
  pusherController.initPusherAndSync();
  WidgetsBinding.instance.addObserver(LifecycleManager());
  NotificationController.initializeNotification();

  await fcmHandler();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> fcmHandler() async {
  FirebaseMessaging.onMessage.listen(FcmNotifications.handleMessageJson);
  FirebaseMessaging.onMessageOpenedApp
      .listen(FcmNotifications.handleMessageJson);
  FirebaseMessaging.onBackgroundMessage(FcmNotifications.handleMessageJson);
  RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    await FcmNotifications.handleMessageJson(remoteMessage);
  }
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
  if (await Permission.ignoreBatteryOptimizations.isDenied) {
    await Permission.ignoreBatteryOptimizations.request();
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
    super.initState();
    _initializeFCM();
  }

  void _initializeFCM() async {
    final logger = Logger();
    FcmService fcmService = FcmService();
    final token = await fcmService.getFcmToken();
    logger.e('FCM Token: $token');
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
