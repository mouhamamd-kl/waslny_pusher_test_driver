import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/models/trip.dart';


class TripAvailableForDriverHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final decodedData = jsonDecode(data);
    final trip = Trip.fromJson(decodedData['trip']);
    print('====== TRIP AVAILABLE FOR DRIVER ======');
    print('Trip ID: ${trip.id}');
    print('=======================================');
  }
}
