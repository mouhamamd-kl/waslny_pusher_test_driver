import 'package:waslny_pusher_test_driver/core/models/trip_location.dart';

class TripRouteLocation {
  final int id;
  final Point location;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripRouteLocation({
    required this.id,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripRouteLocation.fromJson(Map<String, dynamic> json) {
    return TripRouteLocation(
      id: json['id'],
      location: Point.fromJson(json['location']),
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
