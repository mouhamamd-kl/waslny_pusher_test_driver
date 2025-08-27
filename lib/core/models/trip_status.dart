class TripStatus {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripStatus({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripStatus.fromJson(Map<String, dynamic> json) {
    return TripStatus(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
