import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/models/trip_location.dart';

class TripDriverLocationUpdatedHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final location = Point.fromJson(jsonDecode(data)['location']);
    print('====== TRIP DRIVER LOCATION UPDATED ======');
    print('Location: ${location.lat}, ${location.long}');
    print('==========================================');
  }
}
