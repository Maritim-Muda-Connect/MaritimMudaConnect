import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/controllers/e_kta_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/member/controllers/member_controller.dart';
import '../../models/request/chat_message_request.dart';
import '../../models/response/chat_message_response.dart';
import '../../models/response/member_response.dart';

// class ChatService {
//   final _unreadCountController = StreamController<int>.broadcast();
//   final _messageController = StreamController<ChatMessageResponse>.broadcast();

//   Stream<int> get onUnreadCountChanged => _unreadCountController.stream;
//   Stream<ChatMessageResponse> get messageStream => _messageController.stream;

//   Future<MemberResponse> getConversations() async {
//     try {
//       String? token = await UserPreferences().getToken();
//       final response = await http.get(
//         Uri.parse('$baseUrl/chat/conversations'),
//         headers: headerWithToken(token!),
//       );

//       if (response.statusCode == 200) {
//         return MemberResponse.fromJson(jsonDecode(response.body));
//       } else {
//         return MemberResponse(success: false, members: []);
//       }
//     } catch (e) {
//       log('Error getting conversations: $e');
//       return MemberResponse(success: false, members: []);
//     }
//   }

//   Future<List<ChatMessageResponse>> getMessages(int recipientId) async {
//     try {
//       String? token = await UserPreferences().getToken();
//       final response = await http.get(
//         Uri.parse('$baseUrl/chat/messages/$recipientId'),
//         headers: headerWithToken(token!),
//       );

//       if (response.statusCode == 200) {
//         return (jsonDecode(response.body) as List)
//             .map((json) => ChatMessageResponse.fromJson(json))
//             .toList();
//       }
//       return [];
//     } catch (e) {
//       log('Error getting messages: $e');
//       return [];
//     }
//   }

//   Future<ChatMessageResponse?> sendMessage(ChatMessageRequest request) async {
//     try {
//       String? token = await UserPreferences().getToken();
//       final response = await http.post(
//         Uri.parse('$baseUrl/chat/messages'),
//         headers: headerWithToken(token!),
//         body: chatMessageRequestToJson(request),
//       );

//       log("Response: ${response.body}");
//       log("Status Code: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         log(response.body);
//         final message = ChatMessageResponse.fromJson(jsonDecode(response.body));
//         _messageController.add(message);
//         return message;
//       }
//       return null;
//     } catch (e) {
//       log('Error sending message: $e');
//       return null;
//     }
//   }

//   Future<int> getUnreadCount() async {
//     try {
//       String? token = await UserPreferences().getToken();
//       final response = await http.get(
//         Uri.parse('$baseUrl/chat/unread-count'),
//         headers: headerWithToken(token!),
//       );

//       if (response.statusCode == 200) {
//         final count = jsonDecode(response.body)['unread_count'] ?? 0;
//         _unreadCountController.add(count);
//         return count;
//       }
//       return 0;
//     } catch (e) {
//       log('Error getting unread count: $e');
//       return 0;
//     }
//   }

//   Future<bool> markMessageAsRead(String messageId) async {
//     try {
//       String? token = await UserPreferences().getToken();
//       final response = await http.put(
//         Uri.parse('$baseUrl/chat/messages/$messageId/read'),
//         headers: headerWithToken(token!),
//       );

//       if (response.statusCode == 200) {
//         await getUnreadCount();
//         return true;
//       }
//       return false;
//     } catch (e) {
//       log('Error marking message as read: $e');
//       return false;
//     }
//   }

//   void dispose() {
//     _unreadCountController.close();
//     _messageController.close();
//   }
// }

class ChatService {
  //THIS IS A MOCK CHAT SERVICE INTENDED FOR TESTING ONLY
  final _unreadCountController = StreamController<int>.broadcast();
  final _messageController = StreamController<ChatMessageResponse>.broadcast();
  final List<ChatMessageResponse> _mockMessages = [];

  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;

  ChatService._internal() {
    _initializeMockMessages();
  }

  Stream<int> get onUnreadCountChanged => _unreadCountController.stream;
  Stream<ChatMessageResponse> get messageStream => _messageController.stream;
  final currentUserId = Get.find<EKtaController>().userId;

  void _initializeMockMessages() {
    if (_mockMessages.isEmpty) {
      _mockMessages.add(
        ChatMessageResponse(
          id: '1',
          message: "Welcome to MaritimMuda Connect!",
          senderId: '1',
          recipientId: currentUserId.toString(),
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
      );
    }
  }

  Future<bool> deleteMessage(String messageId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final index = _mockMessages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        _mockMessages.removeAt(index);
        _messageController.addStream(Stream.value(ChatMessageResponse(
            id: messageId,
            message: '',
            senderId: '',
            recipientId: '',
            isRead: true)));
        return true;
      }
      return false;
    } catch (e) {
      log('Error deleting message: $e');
      return false;
    }
  }

  Future<ChatMessageResponse?> sendMessage(
      ChatMessageRequest request, String? mediaPath) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentUserId = Get.find<EKtaController>().userId;

    String? mediaUrl;
    String messageType = 'text';

    // if (mediaPath != null) {
    //   mediaUrl =
    //       'file://${DateTime.now().millisecondsSinceEpoch}/${mediaPath.split('/').last}';
    //   messageType = mediaPath.toLowerCase().endsWith('.jpg') ||
    //           mediaPath.toLowerCase().endsWith('.png') ||
    //           mediaPath.toLowerCase().endsWith('.jpeg')
    //       ? 'image'
    //       : 'file';
    //   log('Sending media message: $mediaPath as $messageType');
    // }

    if (mediaPath != null) {
      mediaUrl = mediaPath;
      messageType = mediaPath.toLowerCase().endsWith('.jpg') ||
              mediaPath.toLowerCase().endsWith('.png') ||
              mediaPath.toLowerCase().endsWith('.jpeg')
          ? 'image'
          : 'file';
    }
    final message = ChatMessageResponse(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: request.message,
      senderId: currentUserId.toString(),
      recipientId: request.recipientId.toString(),
      createdAt: DateTime.now(),
      isRead: false,
      messageType: messageType,
      mediaUrl: mediaUrl,
      replyTo: request.replyToMessageId,
    );

    _mockMessages.insert(0, message);
    _messageController.add(message);

    final existingConversation = _mockMessages
            .where((m) =>
                (m.senderId == currentUserId &&
                    m.recipientId == request.recipientId.toString()) ||
                (m.senderId == request.recipientId.toString() &&
                    m.recipientId == currentUserId))
            .length >
        1;

    if (!existingConversation) {
      _unreadCountController.add(0);
    }

    return message;
  }

  Future<List<ChatMessageResponse>> getMessages(int recipientId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentUserId = Get.find<EKtaController>().userId;
    if (currentUserId == null) {
      return [];
    }

    final messages = _mockMessages
        .where((m) =>
            (m.senderId == currentUserId &&
                m.recipientId == recipientId.toString()) ||
            (m.senderId == recipientId.toString() &&
                m.recipientId == currentUserId))
        .toList();
    messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return messages;
  }

  Future<MemberResponse> getConversations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentUserId = Get.find<EKtaController>().userId;
    final memberController = Get.find<MemberController>();

    final memberIds = _mockMessages
        .where((m) =>
            m.senderId == currentUserId || m.recipientId == currentUserId)
        .map((m) => m.senderId == currentUserId ? m.recipientId : m.senderId)
        .toSet();

    if (memberIds.isEmpty) {
      return MemberResponse(success: true, members: []);
    }

    final members = memberIds.map((id) {
      final mockMember = memberController.memberList.firstWhere(
        (m) => m.id.toString() == id,
        orElse: () => Member(
          id: int.parse(id!),
          name: "User $id",
          email: "user$id@example.com",
          photoLink: null,
        ),
      );
      return mockMember;
    }).toList();

    return MemberResponse(
      success: true,
      members: members,
    );
  }

  Future<int> getUnreadCount() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentUserId = Get.find<EKtaController>().userId;

    return _mockMessages
        .where((m) => m.recipientId == currentUserId && !m.isRead!)
        .length;
  }

  Future<bool> markMessageAsRead(String messageId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final messageIndex = _mockMessages.indexWhere((m) => m.id == messageId);
      if (messageIndex != -1) {
        _mockMessages[messageIndex] = ChatMessageResponse(
          id: messageId,
          message: _mockMessages[messageIndex].message,
          senderId: _mockMessages[messageIndex].senderId,
          recipientId: _mockMessages[messageIndex].recipientId,
          createdAt: _mockMessages[messageIndex].createdAt,
          isRead: true,
        );

        final unreadCount = _mockMessages.where((m) => !m.isRead!).length;
        _unreadCountController.add(unreadCount);
        return true;
      }
      return false;
    } catch (e) {
      log('Error marking message as read in mock: $e');
      return false;
    }
  }

  Future<bool> deleteAllMessagesForCurrentChat(int recipientId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final currentUserId = Get.find<EKtaController>().userId;
      _mockMessages.removeWhere((m) =>
          (m.senderId == currentUserId &&
              m.recipientId == recipientId.toString()) ||
          (m.senderId == recipientId.toString() &&
              m.recipientId == currentUserId));
      return true;
    } catch (e) {
      log('Error deleting all messages for chat: $e');
      return false;
    }
  }

  void dispose() {
    _unreadCountController.close();
    _messageController.close();
  }
}
