import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String messageId;
  final String content;
  final String senderId;
  final DateTime createdAt;

  ChatMessage({
    required this.messageId,
    required this.content,
    required this.senderId,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(String id, Map<String, dynamic> json) {
    return ChatMessage(
      messageId: id,
      content: json['content'] ?? '',
      senderId: json['senderId'] ?? 1,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'content': content,
      'senderId': senderId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
