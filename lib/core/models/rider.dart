class Rider {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String? profilePhoto;
  final double rating;
  final double balance;
  final DateTime createdAt;
  final DateTime updatedAt;

  Rider({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.profilePhoto,
    required this.rating,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      profilePhoto: json['profile_photo'],
      rating: json['rating'].toDouble(),
      balance: json['wallet']['balance'].toDouble(),
      createdAt: DateTime.parse(json['dates']['created']),
      updatedAt: DateTime.parse(json['dates']['updated']),
    );
  }
}
