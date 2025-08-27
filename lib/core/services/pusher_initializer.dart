import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class PusherInitializer {
  final String authToken;
  final ServiceInstance service;
  final logger = Logger();

  PusherInitializer(this.authToken, this.service);

  Future<void> initPusherAndSync() async {
    try {
      // Get pusher config
      final configResponse = await http.get(
        Uri.parse(
            "https://waslny-project.vercel.app/api/api/driver/pusher/config"),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (configResponse.statusCode != 200) {
        print('Failed to get Pusher config: ${configResponse.statusCode}');
        return;
      }

      final configData = json.decode(configResponse.body)['data'];
      final key = configData['key'];
      final cluster = configData['cluster'];

      // Get channels
      final syncResponse = await http.get(
        Uri.parse("https://waslny-project.vercel.app/api/api/sync/driver"),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (syncResponse.statusCode != 200) {
        logger.e('Failed to sync channels: ${syncResponse.statusCode}');
        return;
      }
      
      final channels = json.decode(syncResponse.body)['data'] as List;
      final channelNames = channels.map((c) => c['channel'] as String).toList();

      // Invoke main isolate to setup pusher
      service.invoke(
        'setupPusher',
        {
          'apiKey': key,
          'cluster': cluster,
          'authToken': authToken,
          'channels': channelNames,
        },
      );

    } catch (e) {
      print('Error in initPusherAndSync: $e');
    }
  }
}
