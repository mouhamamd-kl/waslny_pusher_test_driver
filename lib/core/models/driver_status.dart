class DriverStatus {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverStatus({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverStatus.fromJson(Map<String, dynamic> json) {
    return DriverStatus(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
