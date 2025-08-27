import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/driver_controller.dart';

class UpdateLocationScreen extends StatelessWidget {
  final DriverController controller = Get.find();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Location'),
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
              controller: latController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: longController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final body = {
                  "location": {
                    "type": "Point",
                    "coordinates": [
                      double.parse(longController.text),
                      double.parse(latController.text)
                    ]
                  }
                };
                controller.makeRequest('/location', body: body);
              },
              child: Text('Update Location'),
            ),
          ],
        ),
      ),
    );
  }
}
