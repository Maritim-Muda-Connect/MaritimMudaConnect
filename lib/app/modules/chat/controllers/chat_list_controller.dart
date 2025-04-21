import 'dart:developer';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/routes/app_pages.dart';
import '../../../data/services/home/chat_service.dart';
import '../../../data/models/response/member_response.dart';
import '../../../data/models/response/chat_message_response.dart';
import '../../../modules/e_kta/controllers/e_kta_controller.dart';

class ChatListController extends GetxController {
  final ChatService chatService =ChatService();

  final conversations = <Member>[].obs;
  final lastMessages = <String, ChatMessageResponse>{}.obs;
  final unreadCounts = <String, int>{}.obs;
  final isLoading = false.obs;
  int get totalUnreadCount =>
      unreadCounts.values.fold(0, (sum, count) => sum + count);

  ChatListController();

  Future<void> updateUnreadCount() async {
    try {
      final count = await chatService.getUnreadCount();
      final ektaController = Get.find<EKtaController>();
      final currentUserId = ektaController.userId;

      if (currentUserId != null) {
        unreadCounts[currentUserId] = count;
      }
    } catch (e) {
      log('Error updating unread count: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadConversations();
    setupMessageListener();
    updateUnreadCount();
  }

  Future<void> loadConversations() async {
    try {
      isLoading.value = true;
      final response = await chatService.getConversations();
      conversations.assignAll(response.memberList);

      for (var member in conversations) {
        final messages = await chatService.getMessages(member.memberId.toString());
        if (messages.isNotEmpty) {
          lastMessages[member.memberId.toString()] = messages.first;
        }
        final unreadCount = await chatService.getUnreadCount();
        unreadCounts[member.memberId.toString()] = unreadCount;
      }
    } catch (e) {
      log('Error loading conversations: $e');
      Get.snackbar(
        'Error',
        'Failed to load conversations',
        backgroundColor: Get.theme.colorScheme.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setupMessageListener() {
    chatService.messageStream.listen((message) {
      lastMessages[message.senderId!] = message;

      final ektaController = Get.find<EKtaController>();
      final currentUserId = ektaController.userId;

      if (message.senderId != currentUserId) {
        unreadCounts[message.senderId!] =
            (unreadCounts[message.senderId!] ?? 0) + 1;
      }
    });
  }

  void navigateToChat(Member member) {
    Get.toNamed(
      Routes.CHAT,
      arguments: {
        'recipientId': member.id,
        'recipientName': member.name,
      },
    );
  }

  @override
  void onClose() {
    // Clean up any resources
    super.onClose();
  }
}
