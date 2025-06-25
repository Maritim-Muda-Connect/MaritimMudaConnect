import 'dart:convert';

String chatMessageRequestToJson(ChatMessageRequest data) => 
    json.encode(data.toJson());

class ChatMessageRequest {
  final int recipientId;
  final String message;
  final String messageType;
  final String? replyToMessageId;

  ChatMessageRequest({
    required this.recipientId,
    required this.message,
    this.messageType = 'text',
    this.replyToMessageId,
  });

  Map<String, dynamic> toJson() => {
    "recipient_id": recipientId,
    "message": message,
    "message_type": messageType,
    "reply_to_message_id": replyToMessageId,
  };
}