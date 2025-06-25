import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/chat_message_response.dart';
import 'package:maritimmuda_connect/app/data/models/request/chat_message_request.dart';
import '../../../data/services/home/chat_service.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/controllers/e_kta_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ChatController extends GetxController {
  final ChatService chatService;
  final int recipientId;

  final messages = <ChatMessageResponse>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;
  final replyingTo = Rxn<ChatMessageResponse>();
  final searchQuery = ''.obs;
  final isSearching = false.obs;

  ChatController({
    required this.chatService,
    required this.recipientId,
  });

  String? get currentUserId {
    final ektaController = Get.find<EKtaController>();
    return ektaController.userId;
  }

  @override
  void onInit() {
    super.onInit();
    loadMessages();
    setupMessageListener();
    maybeRequestNotificationPermission();
  }

  List<ChatMessageResponse> get filteredMessages {
    if (searchQuery.value.isEmpty) return messages;
    return messages
        .where((m) => (m.message ?? '')
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  Future<void> deleteAllMessagesForCurrentChat() async {
    final success =
        await chatService.deleteAllMessagesForCurrentChat(recipientId);
    if (success) {
      messages.clear();
      Get.snackbar(
        'Chat cleared',
        'All messages have been deleted for you.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to clear chat.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> maybeRequestNotificationPermission() async {
    final plugin = FlutterLocalNotificationsPlugin();
    final androidImpl = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final granted = await androidImpl?.areNotificationsEnabled() ?? false;
    if (!granted) {
      await androidImpl?.requestNotificationsPermission();
    }
  }

  Future<void> loadMessages() async {
    try {
      isLoading.value = true;
      final response = await chatService.getMessages(recipientId);
      messages.assignAll(response);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load messages',
        backgroundColor: Get.theme.colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String text, {String? mediaPath}) async {
    if (text.trim().isEmpty && mediaPath == null) return;

    try {
      isSending.value = true;

      final request = ChatMessageRequest(
        recipientId: recipientId,
        message: text,
        replyToMessageId: replyingTo.value?.id,
      );

      final message = await chatService.sendMessage(request, mediaPath);

      if (message != null) {
        messages.insert(0, message);
      }
      setReplyingTo(null);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message',
        backgroundColor: Get.theme.colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSending.value = false;
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      final success = await chatService.deleteMessage(messageId);
      if (success) {
        messages.removeWhere((m) => m.id == messageId);
      } else {
        Get.snackbar('Error', 'Failed to delete message',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete message',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void setupMessageListener() {
    chatService.messageStream.listen((ChatMessageResponse message) {
      if (message.senderId == recipientId) {
        messages.insert(0, message);
        markAsRead(message.id!);
      }
    });
  }

  Future<void> markAsRead(String messageId) async {
    try {
      await chatService.markMessageAsRead(messageId);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to mark message as read',
        backgroundColor: Get.theme.colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setReplyingTo(ChatMessageResponse? message) {
    replyingTo.value = message;
  }

  void addReaction(String messageId, String emoji) {
    final idx = messages.indexWhere((m) => m.id == messageId);
    if (idx != -1) {
      final msg = messages[idx];
      final newReactions = Map<String, int>.from(msg.reactions ?? {});
      newReactions[emoji] = (newReactions[emoji] ?? 0) + 1;
      messages[idx] = ChatMessageResponse(
        id: msg.id,
        senderId: msg.senderId,
        recipientId: msg.recipientId,
        message: msg.message,
        messageType: msg.messageType,
        mediaUrl: msg.mediaUrl,
        isRead: msg.isRead,
        createdAt: msg.createdAt,
        replyTo: msg.replyTo,
        reactions: newReactions,
      );
      messages.refresh();
    }
  }
}
