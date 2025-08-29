import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/services/pusher_service.dart';

class UnsubscribeHandler implements EventHandler {
  @override
  void handle(dynamic data) {
    final channels = jsonDecode(data)['channels'];
    if (channels is String) {
      PusherService().pusher.unsubscribe(channelName: channels);
    } else if (channels is List) {
      for (var channel in channels) {
        PusherService().pusher.unsubscribe(channelName: channel.toString());
      }
    }
  }
}
