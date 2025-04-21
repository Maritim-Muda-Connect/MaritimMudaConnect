import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../models/request/chat_message_request.dart';
import '../../models/response/chat_message_response.dart';
import '../../models/response/member_response.dart';
import '../config.dart';
import '../../utils/user_preference.dart';

class ChatService {
  final _unreadCountController = StreamController<int>.broadcast();
  final _messageController = StreamController<ChatMessageResponse>.broadcast();
  
  Stream<int> get onUnreadCountChanged => _unreadCountController.stream;
  Stream<ChatMessageResponse> get messageStream => _messageController.stream;

  Future<MemberResponse> getConversations() async {
    try {
      String? token = await UserPreferences().getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/chat/conversations'),
        headers: headerWithToken(token!),
      );

      if (response.statusCode == 200) {
        return MemberResponse.fromJson(jsonDecode(response.body));
      } else {
        return MemberResponse(success: false, members: []);
      }
    } catch (e) {
      log('Error getting conversations: $e');
      return MemberResponse(success: false, members: []);
    }
  }

  Future<List<ChatMessageResponse>> getMessages(String recipientId) async {
    try {
      String? token = await UserPreferences().getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/chat/messages/$recipientId'),
        headers: headerWithToken(token!),
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((json) => ChatMessageResponse.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      log('Error getting messages: $e');
      return [];
    }
  }

  Future<ChatMessageResponse?> sendMessage(ChatMessageRequest request) async {
    try {
      String? token = await UserPreferences().getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/chat/messages'),
        headers: headerWithToken(token!),
        body: chatMessageRequestToJson(request),
      );

      if (response.statusCode == 200) {
        final message = ChatMessageResponse.fromJson(jsonDecode(response.body));
        _messageController.add(message);
        return message;
      }
      return null;
    } catch (e) {
      log('Error sending message: $e');
      return null;
    }
  }

  Future<int> getUnreadCount() async {
    try {
      String? token = await UserPreferences().getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/chat/unread-count'),
        headers: headerWithToken(token!),
      );

      if (response.statusCode == 200) {
        final count = jsonDecode(response.body)['unread_count'] ?? 0;
        _unreadCountController.add(count);
        return count;
      }
      return 0;
    } catch (e) {
      log('Error getting unread count: $e');
      return 0;
    }
  }

  Future<bool> markMessageAsRead(String messageId) async {
    try {
      String? token = await UserPreferences().getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/chat/messages/$messageId/read'),
        headers: headerWithToken(token!),
      );

      if (response.statusCode == 200) {
        await getUnreadCount();
        return true;
      }
      return false;
    } catch (e) {
      log('Error marking message as read: $e');
      return false;
    }
  }

  void dispose() {
    _unreadCountController.close();
    _messageController.close();
  }
}