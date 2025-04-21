import 'dart:developer';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/chat_message_response.dart';
import 'package:maritimmuda_connect/app/data/models/request/chat_message_request.dart';
import '../../../data/services/home/chat_service.dart';

class ChatController extends GetxController {
  final ChatService chatService;
  final String recipientId;
  
  final messages = <ChatMessageResponse>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;

  ChatController({
    required this.chatService,
    required this.recipientId,
  });

  @override
  void onInit() {
    super.onInit();
    loadMessages();
    setupMessageListener();
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
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      isSending.value = true;
      
      final request = ChatMessageRequest(
        recipientId: recipientId,
        message: text.trim(),
      );

      final response = await chatService.sendMessage(request);
      
      if (response != null) {
        messages.insert(0, response);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message',
        backgroundColor: Get.theme.colorScheme.error,
      );
    } finally {
      isSending.value = false;
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
      log('Error marking message as read: $e');
    }
  }

}
