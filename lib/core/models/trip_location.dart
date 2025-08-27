class TripLocation {
  final int id;
  final Point location;
  final int locationOrder;
  final String locationType;
  final bool isCompleted;
  final DateTime? estimatedArrivalTime;
  final DateTime? actualArrivalTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripLocation({
    required this.id,
    required this.location,
    required this.locationOrder,
    required this.locationType,
    required this.isCompleted,
    this.estimatedArrivalTime,
    this.actualArrivalTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
      id: json['id'],
      location: Point.fromJson(json['location']),
      locationOrder: json['location_order'],
      locationType: json['location_type'],
      isCompleted: json['is_completed'],
      estimatedArrivalTime: json['estimated_arrival_time'] != null
          ? DateTime.parse(json['estimated_arrival_time'])
          : null,
      actualArrivalTime: json['actual_arrival_time'] != null
          ? DateTime.parse(json['actual_arrival_time'])
          : null,
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}

class Point {
  final double lat;
  final double long;

  Point({required this.lat, required this.long});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      lat: json['coordinates']['lat'],
      long: json['coordinates']['long'],
    );
  }
}
