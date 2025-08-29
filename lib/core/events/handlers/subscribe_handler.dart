import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/services/pusher_service.dart';

class SubscribeHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final channels = jsonDecode(data)['channels'];
    if (channels is String) {
      PusherService().subscribeToChannel(channels);
    } else if (channels is List) {
      for (var channel in channels) {
        PusherService().subscribeToChannel(channel.toString());
      }
    }
  }
}
