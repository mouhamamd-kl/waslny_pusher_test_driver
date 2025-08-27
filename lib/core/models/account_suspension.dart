import 'package:waslny_pusher_test_driver/core/models/suspension.dart';

class AccountSuspension {
  final int id;
  final Suspension suspension;
  final DateTime? liftedAt;
  final bool isPermanent;
  final DateTime? suspendedUntil;
  final DateTime createdAt;
  final DateTime updatedAt;

  AccountSuspension({
    required this.id,
    required this.suspension,
    this.liftedAt,
    required this.isPermanent,
    this.suspendedUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AccountSuspension.fromJson(Map<String, dynamic> json) {
    return AccountSuspension(
      id: json['id'],
      suspension: Suspension.fromJson(json['suspension']),
      liftedAt:
          json['lifted_at'] != null ? DateTime.parse(json['lifted_at']) : null,
      isPermanent: json['is_permanent'],
      suspendedUntil: json['suspended_until'] != null
          ? DateTime.parse(json['suspended_until'])
          : null,
      createdAt: DateTime.parse(json['dates']['created_at']),
      updatedAt: DateTime.parse(json['dates']['updated_at']),
    );
  }
}
