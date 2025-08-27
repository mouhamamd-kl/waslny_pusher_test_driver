class Notification {
  final String title;
  final String body;
  final DateTime sentAt;

  Notification({
    required this.title,
    required this.body,
    required this.sentAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      body: json['body'],
      sentAt: DateTime.parse(json['sent_at']),
    );
  }
}
