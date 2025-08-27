class Suspension {
  final int id;
  final String reason;
  final String userMsg;
  final DateTime createdAt;
  final DateTime updatedAt;

  Suspension({
    required this.id,
    required this.reason,
    required this.userMsg,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Suspension.fromJson(Map<String, dynamic> json) {
    return Suspension(
      id: json['id'],
      reason: json['reason'],
      userMsg: json['user_msg'],
      createdAt: DateTime.parse(json['dates']['created_at']),
      updatedAt: DateTime.parse(json['dates']['updated_at']),
    );
  }
}
