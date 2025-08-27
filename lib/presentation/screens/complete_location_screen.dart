import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/driver_controller.dart';

class CompleteLocationScreen extends StatelessWidget {
  final DriverController controller = Get.find();
  final TextEditingController locationIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Location'),
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
            TextField(
              controller: locationIdController,
              decoration: InputDecoration(labelText: 'Location ID (optional)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final body = {
                  "location_id": locationIdController.text.isNotEmpty
                      ? int.parse(locationIdController.text)
                      : null,
                };
                controller.makeRequest('/complete-location', body: body);
              },
              child: Text('Complete Location'),
            ),
          ],
        ),
      ),
    );
  }
}
