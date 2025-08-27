class PaymentMethod {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
