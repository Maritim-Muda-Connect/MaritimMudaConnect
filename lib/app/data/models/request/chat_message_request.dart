import 'dart:convert';

String chatMessageRequestToJson(ChatMessageRequest data) => 
    json.encode(data.toJson());

class ChatMessageRequest {
  final String recipientId;
  final String message;
  final String messageType;

  ChatMessageRequest({
    required this.recipientId,
    required this.message,
    this.messageType = 'text',
  });

  Map<String, dynamic> toJson() => {
    "recipient_id": recipientId,
    "message": message,
    "message_type": messageType,
  };
}