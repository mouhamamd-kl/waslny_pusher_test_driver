import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/driver_controller.dart';

class CompleteTripScreen extends StatelessWidget {
  final DriverController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.tripIdController,
              decoration: InputDecoration(labelText: 'Trip ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.makeRequest('/complete'),
              child: Text('Complete Trip'),
            ),
          ],
        ),
      ),
    );
  }
}
