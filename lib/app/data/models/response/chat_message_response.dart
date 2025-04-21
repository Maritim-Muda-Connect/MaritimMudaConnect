import 'dart:convert';

ChatMessageResponse chatMessageResponseFromJson(String str) =>
    ChatMessageResponse.fromJson(json.decode(str));

class ChatMessageResponse {
  final String? id;
  final String? senderId;
  final String? recipientId;
  final String? message;
  final String? messageType;
  final bool? isRead;
  final DateTime? createdAt;

  ChatMessageResponse({
    this.id,
    this.senderId,
    this.recipientId,
    this.message,
    this.messageType,
    this.isRead,
    this.createdAt,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      ChatMessageResponse(
        id: json["id"],
        senderId: json["sender_id"],
        recipientId: json["recipient_id"],
        message: json["message"],
        messageType: json["message_type"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );
}