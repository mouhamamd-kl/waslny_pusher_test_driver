import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';

class TripUnavailableHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final decodedData = jsonDecode(data);
    print('====== TRIP UNAVAILABLE ======');
    print('Trip ID: ${decodedData['trip_id']}');
    print('==============================');
    print('============================');
  }
}
