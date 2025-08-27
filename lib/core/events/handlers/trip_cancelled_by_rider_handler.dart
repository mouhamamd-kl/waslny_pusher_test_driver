import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/models/trip.dart';


class TripCancelledByRiderHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final decodedData = jsonDecode(data);
    final trip = Trip.fromJson(decodedData['trip']);
    print('====== TRIP CANCELLED BY RIDER ======');
    print('Trip ID: ${trip.id}');
    print('=====================================');
  }
}
