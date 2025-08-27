import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:waslny_pusher_test_driver/core/services/pusher_service.dart';

class DriverController extends GetxController {
  final PusherService pusherService = PusherService();
  final urlController = TextEditingController(text: "https://waslny-project.vercel.app/api/trips/driver/");
  final tripIdController = TextEditingController();
  final authTokenController = TextEditingController(text: "103|GscUMwMpztxjXUmjkalPBxeZJ6ieifmLN6Ao6VbUef20e669");

  @override
  void onInit() {
    super.onInit();
    // initPusherAndSync();
  }

  Future<void> initPusherAndSync() async {
    try {
      final response = await http.get(
        Uri.parse("https://waslny-project.vercel.app/api/api/driver/pusher/config"),
        headers: {
          'Authorization': 'Bearer ${authTokenController.text}',
        },
      );

      if (response.statusCode == 200) {
        final config = json.decode(response.body)['data'];
        await pusherService.initPusher(
          config['key'],
          config['cluster'],
          authTokenController.text,
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
        Uri.parse("https://waslny-project.vercel.app/api/sync/driver"),
        headers: {
          'Authorization': 'Bearer ${authTokenController.text}',
        },
      );

      if (response.statusCode == 200) {
        final channels = json.decode(response.body)['data'] as List;
        for (var channel in channels) {
          pusherService.subscribeToChannel(channel['name']);
        }
      } else {
        print('Failed to sync channels: ${response.statusCode}');
      }
    } catch (e) {
      print('Error syncing channels: $e');
    }
  }

  Future<void> makeRequest(String endpoint, {Object? body}) async {
    final url = urlController.text + tripIdController.text + endpoint;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authTokenController.text}',
        },
        body: body != null ? json.encode(body) : null,
      );

      print('URL: $url');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
