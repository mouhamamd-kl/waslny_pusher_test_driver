import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:logger/logger.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:waslny_pusher_test_driver/core/events/event_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/account_suspended_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/driver_approaching_pickup_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/driver_arrived_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/notification_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_activation_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_cancelled_by_rider_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_completed_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_driver_location_updated_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_location_completed_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_started_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_time_near_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_available_for_driver_handler.dart';
import 'package:waslny_pusher_test_driver/core/events/handlers/trip_unavailable_handler.dart';
import 'package:waslny_pusher_test_driver/core/services/lifecycle_manager.dart';

class PusherService {
  final logger = Logger();
  late PusherChannelsFlutter pusher;
  NotificationHandler notificationHandler = NotificationHandler();
  final Map<String, EventHandler> _eventHandlers = {
    'account.suspended': AccountSuspendedHandler(),
    'driver.approaching.pickup': DriverApproachingPickupHandler(),
    'driver.arrived': DriverArrivedHandler(),
    'trip.activation': TripActivationHandler(),
    'trip.cancelled.by.rider': TripCancelledByRiderHandler(),
    'trip.completed': TripCompletedHandler(),
    'trip.driver.location.updated': TripDriverLocationUpdatedHandler(),
    'trip.location.completed': TripLocationCompletedHandler(),
    'trip.started': TripStartedHandler(),
    'trip.time.near': TripTimeNearHandler(),
    'trip.available': TripAvailableForDriverHandler(),
    'trip.unavailable': TripUnavailableHandler(),
  };
  @pragma('vm:entry-point')
  Future<void> initPusher(
      String apiKey, String cluster, String authToken) async {
    try {
      pusher = PusherChannelsFlutter.getInstance();
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        authEndpoint: "https://waslny-project.vercel.app/api/broadcasting/auth",
        onAuthorizer: (channelName, socketId, options) async {
          return {
            'auth': 'Bearer $authToken',
          };
        },
      );
      await pusher.connect();
    } catch (e) {
      logger.e("ERROR: $e");
    }
  }

  @pragma('vm:entry-point')
  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    logger.i("Connection state changed from $previousState to $currentState");
    if (currentState == 'connected') {
      logger.i("Successfully connected to Pusher");
    }
  }

  @pragma('vm:entry-point')
  void onError(String message, int? code, dynamic e) {
    logger.e("onError: $message code: $code exception: $e");
  }

  @pragma('vm:entry-point')
  void onEvent(PusherEvent event) {
    logger.e(event.eventName);
    notificationHandler.handle(event.data);
    final handler = _eventHandlers[event.eventName];
    if (handler != null) {
      if (!LifecycleManager.isBackground) {
        handler.handle(event.data);
      }
    } else {
      logger.w('Received unhandled event: ${event.eventName}');
    }
  }

  @pragma('vm:entry-point')
  void onSubscriptionSucceeded(String channelName, dynamic data) {
    logger.i("onSubscriptionSucceeded: $channelName data: $data");
  }

  @pragma('vm:entry-point')
  void onSubscriptionError(String message, dynamic e) {
    logger.e("onSubscriptionError: $message Exception: $e");
  }

  @pragma('vm:entry-point')
  void onDecryptionFailure(String event, String reason) {
    logger.w("onDecryptionFailure: $event reason: $reason");
  }

  @pragma('vm:entry-point')
  void onMemberAdded(String channelName, PusherMember member) {
    logger.i("onMemberAdded: $channelName user: $member");
  }

  @pragma('vm:entry-point')
  void onMemberRemoved(String channelName, PusherMember member) {
    logger.i("onMemberRemoved: $channelName user: $member");
  }

  @pragma('vm:entry-point')
  void subscribeToChannel(String channelName) {
    pusher.subscribe(channelName: channelName);
  }

  @pragma('vm:entry-point')
  void disconnect() {
    pusher.disconnect();
  }

  EventHandler? getEventHandler(String eventName) {
    return _eventHandlers[eventName];
  }
}
