
import 'dart:convert';

ChatMessageResponse chatMessageResponseFromJson(String str) =>
    ChatMessageResponse.fromJson(json.decode(str));

class ChatMessageResponse {
  final String? id;
  final String? senderId;
  final String? recipientId;
  final String? message;
  final String? messageType;
  final String? mediaUrl;
  final bool? isRead;
  final DateTime? createdAt;
  final String? replyTo;
  final Map<String, int>? reactions;

  ChatMessageResponse({
    this.id,
    this.senderId,
    this.recipientId,
    this.message,
    this.messageType = 'text',
    this.mediaUrl,
    this.isRead,
    this.createdAt,
    this.replyTo,
    this.reactions = const {},
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      ChatMessageResponse(
        id: json["id"],
        senderId: json["sender_id"],
        recipientId: json["recipient_id"],
        message: json["message"],
        messageType: json["message_type"] ?? 'text',
        mediaUrl: json["media_url"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        replyTo: json["reply_to"],
        reactions: json["reactions"] == null
            ? {}
            : Map<String, int>.from(json["reactions"]),
      );
}
