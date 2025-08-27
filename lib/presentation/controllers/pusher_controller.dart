import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/services/pusher_service.dart';

class PusherController {
  final PusherService pusherService = PusherService();
  final String authToken;
  final logger = Logger();

  PusherController(this.authToken);

  Future<void> initPusherAndSync() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://waslny-project.vercel.app/api/api/driver/pusher/config"),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        logger.e(json.decode(response.body)['data']['key']);
        var key = json.decode(response.body)['data']['key'];
        var cluster = json.decode(response.body)['data']['cluster'];
        await pusherService.initPusher(
          key,
          cluster,
          authToken,
        );
        syncAndSubscribe();
      } else {
        print('Failed to get Pusher config: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting Pusher config: $e');
    }
  }

  Future<void> syncAndSubscribe() async {
    try {
      final response = await http.get(
        Uri.parse("https://waslny-project.vercel.app/api/api/sync/driver"),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final channels = json.decode(response.body)['data'] as List;
        logger.e(json.decode(response.body));
        for (var channel in channels) {
          // pusherService.subscribeToChannel(channel['name']);
          //the bug was that i was trying to access channel['name'] which is not exist the right key is channel['channel']
          logger.e(channel['channel']);
          pusherService.subscribeToChannel(channel['channel']);
        }
      } else {
        logger.e('Failed to sync channels: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error syncing channels: $e');
    }
  }
}
