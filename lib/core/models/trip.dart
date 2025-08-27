import 'package:waslny_pusher_test_driver/core/models/coupon.dart';
import 'package:waslny_pusher_test_driver/core/models/driver.dart';
import 'package:waslny_pusher_test_driver/core/models/payment_method.dart';
import 'package:waslny_pusher_test_driver/core/models/rider.dart';
import 'package:waslny_pusher_test_driver/core/models/trip_location.dart';
import 'package:waslny_pusher_test_driver/core/models/trip_route_location.dart';
import 'package:waslny_pusher_test_driver/core/models/trip_status.dart';
import 'package:waslny_pusher_test_driver/core/models/trip_time_type.dart';
import 'package:waslny_pusher_test_driver/core/models/trip_type.dart';

class Trip {
  final int id;
  final Driver? driver;
  final Rider? rider;
  final TripStatus? status;
  final TripType? type;
  final TripTimeType? timeType;
  final List<TripLocation> locations;
  final List<TripRouteLocation> routeLocations;
  final Coupon? coupon;
  final PaymentMethod? paymentMethod;
  final DateTime? startTime;
  final DateTime? requestedTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final double? distanceMeters;
  final double? distanceKilometers;
  final double? expectedFare;
  final double? fare;

  Trip({
    required this.id,
    this.driver,
    this.rider,
    this.status,
    this.type,
    this.timeType,
    required this.locations,
    required this.routeLocations,
    this.coupon,
    this.paymentMethod,
    this.startTime,
    this.requestedTime,
    this.endTime,
    this.durationMinutes,
    this.distanceMeters,
    this.distanceKilometers,
    this.expectedFare,
    this.fare,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      rider: json['rider'] != null ? Rider.fromJson(json['rider']) : null,
      status:
          json['status'] != null ? TripStatus.fromJson(json['status']) : null,
      type: json['type'] != null ? TripType.fromJson(json['type']) : null,
      timeType: json['time_type'] != null
          ? TripTimeType.fromJson(json['time_type'])
          : null,
      locations: (json['locations'] as List)
          .map((i) => TripLocation.fromJson(i))
          .toList(),
      routeLocations: (json['route_locations'] as List)
          .map((i) => TripRouteLocation.fromJson(i))
          .toList(),
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
      paymentMethod: json['payment_method'] != null
          ? PaymentMethod.fromJson(json['payment_method'])
          : null,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      requestedTime: json['requested_time'] != null
          ? DateTime.parse(json['requested_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      durationMinutes: json['duration_minutes'],
      distanceMeters: json['distance']['meters']?.toDouble(),
      distanceKilometers: json['distance']['kilometers']?.toDouble(),
      expectedFare: json['expected_fare']?.toDouble(),
      fare: json['fare']?.toDouble(),
    );
  }
}
