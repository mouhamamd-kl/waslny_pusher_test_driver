import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waslny_pusher_test_driver/core/services/notification_service.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/driver_controller.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/accept_trip_screen.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/update_location_screen.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/arrive_screen.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/start_trip_screen.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/complete_location_screen.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/complete_trip_screen.dart';
import 'package:waslny_pusher_test_driver/presentation/screens/cancel_trip_screen.dart';

class HomeScreen extends StatelessWidget {
  final DriverController controller = Get.put(DriverController());
  final NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Testing Menu'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller.authTokenController,
                decoration: InputDecoration(labelText: 'Auth Token'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.tripIdController,
                decoration: InputDecoration(labelText: 'Trip ID'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Get.to(() => AcceptTripScreen()),
                child: Text('Accept Trip'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => UpdateLocationScreen()),
                child: Text('Update Location'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => ArriveScreen()),
                child: Text('Arrive'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => StartTripScreen()),
                child: Text('Start Trip'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => CompleteLocationScreen()),
                child: Text('Complete Location'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => CompleteTripScreen()),
                child: Text('Complete Trip'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => CancelTripScreen()),
                child: Text('Cancel Trip'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                    if (!isAllowed) {
                      AwesomeNotifications().requestPermissionToSendNotifications();
                    }
                  });
                },
                child: Text('Request Permissions'),
              ),
              ElevatedButton(
                onPressed: () {
                  notificationService.showNotification(
                    title: 'Test Notification',
                    body: 'This is a test notification from the app.',
                  );
                },
                child: Text('Send Test Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
