class TripType {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripType({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripType.fromJson(Map<String, dynamic> json) {
    return TripType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
