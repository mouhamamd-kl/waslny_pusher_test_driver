import 'package:waslny_pusher_test_driver/core/models/driver_status.dart';

class Driver {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String nationalNumber;
  final String phone;
  final String email;
  final String? profilePhoto;
  final String? driverLicensePhoto;
  final double rating;
  final double balance;
  final DriverStatus driverStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.nationalNumber,
    required this.phone,
    required this.email,
    this.profilePhoto,
    this.driverLicensePhoto,
    required this.rating,
    required this.balance,
    required this.driverStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      nationalNumber: json['national_number'],
      phone: json['phone'],
      email: json['email'],
      profilePhoto: json['profile_photo'],
      driverLicensePhoto: json['driver_license_photo'],
      rating: json['rating'].toDouble(),
      balance: json['wallet']['balance'].toDouble(),
      driverStatus: DriverStatus.fromJson(json['driver_status']),
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
