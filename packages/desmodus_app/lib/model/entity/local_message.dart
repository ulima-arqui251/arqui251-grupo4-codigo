import 'dart:io';

class LocalMessage {
  final String? sender;
  final String message;
  final DateTime createdAt;
  final List<File> images;

  LocalMessage({
    this.sender,
    required this.message,
    required this.createdAt,
    this.images = const [],
  });

  factory LocalMessage.fromJson(Map<String, dynamic> json) => LocalMessage(
    sender: json["sender"],
    message: json["message"],
    createdAt:
        json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
  );
}
