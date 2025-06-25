import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/routes/app_pages.dart';
import '../../../data/services/home/chat_service.dart';
import '../../../data/models/response/member_response.dart';
import '../../../data/models/response/chat_message_response.dart';
import '../../../modules/e_kta/controllers/e_kta_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:maritimmuda_connect/main.dart';

class ChatListController extends GetxController {
  final ChatService chatService = ChatService();

  final conversations = <Member>[].obs;
  final lastMessages = <String, ChatMessageResponse>{}.obs;
  final unreadCounts = <String, int>{}.obs;
  final isLoading = false.obs;
  final RxSet<String> hiddenConversations = <String>{}.obs;
  final RxSet<String> mutedConversations = <String>{}.obs;

  int get totalUnreadCount =>
      unreadCounts.values.fold(0, (sum, count) => sum + count);

  ChatListController();

  Future<void> updateUnreadCount() async {
    try {
      final count = await chatService.getUnreadCount();
      final ektaController = Get.find<EKtaController>();
      final currentUserId = ektaController.userId;
      unreadCounts.clear();

      if (currentUserId != null) {
        unreadCounts[currentUserId] = count;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not update unread count. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String getLastMessageText(ChatMessageResponse? lastMessage) {
    if (lastMessage == null) return '';

    switch (lastMessage.messageType) {
      case 'image':
        return '📷 Photo';
      case 'text':
      default:
        return lastMessage.message ?? '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    setupMessageListener();
    updateUnreadCount();
  }

  void onViewOpened() {
    updateUnreadCount();
    loadConversations();
  }

  Future<void> loadConversations() async {
    try {
      isLoading.value = true;
      final currentUserId = Get.find<EKtaController>().userId;
      final response = await chatService.getConversations();
      conversations.assignAll(response.members
              ?.where((m) => !hiddenConversations.contains(m.id.toString()))
              .toList() ??
          []);

      for (var member in conversations) {
        final messages = await chatService.getMessages(member.id!);
        if (messages.isNotEmpty) {
          lastMessages[member.id.toString()] = messages.first;
        }

        // Calculate unread count using current user ID
        final unreadCount = messages
            .where((m) => m.recipientId == currentUserId && !m.isRead!)
            .length;
        unreadCounts[member.id.toString()] = unreadCount;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        "Messages could not be loaded. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  final searchQuery = ''.obs;

  List<Member> get filteredConversations {
    if (searchQuery.value.isEmpty) return conversations;
    return conversations
        .where((m) => (m.name ?? '')
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void markAllAsRead() {
    for (final key in unreadCounts.keys) {
      unreadCounts[key] = 0;
    }
    unreadCounts.refresh();
    Get.snackbar('All read', 'All conversations marked as read.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void setupMessageListener() {
    chatService.messageStream.listen((message) {
      final ektaController = Get.find<EKtaController>();
      final currentUserId = ektaController.userId;

      final memberId = message.senderId == currentUserId
          ? message.recipientId
          : message.senderId;

      lastMessages[memberId!] = message;

      if (hiddenConversations.contains(memberId)) {
        hiddenConversations.remove(memberId);
        loadConversations();
      }

      if (!conversations.any((m) => m.id.toString() == memberId)) {
        loadConversations();
      } else {
        if (message.senderId != currentUserId) {
          unreadCounts[message.senderId!] =
              (unreadCounts[message.senderId!] ?? 0) + 1;
        }
        conversations.refresh();
      }
      if (!Get.currentRoute.contains('CHAT') ||
          Get.arguments?['recipientId'] != memberId) {
        showChatNotification(
          'New message',
          message.message ?? '',
          memberId,
          messageType: message.messageType,
        );
      }
    });
  }

  void navigateToChat(Member member) {
    Get.toNamed(
      Routes.CHAT,
      arguments: {
        'recipientId': member.id,
        'recipientName': member.name,
        'recipientPhoto': member.photoLink,
      },
    );
  }

  void deleteConversation(String memberId) {
    hiddenConversations.add(memberId);
    conversations.removeWhere((m) => m.id.toString() == memberId);
    Get.snackbar(
        'Deleted', 'Conversation deleted. It will reappear if you chat again.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void deleteAllConversations() {
    for (final member in conversations) {
      hiddenConversations.add(member.id.toString());
    }
    conversations.clear();
    Get.snackbar('Deleted', 'All conversations deleted.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void muteConversation(String memberId) {
    mutedConversations.add(memberId);
    Get.snackbar('Muted', 'You will not receive notifications from this user.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void unmuteConversation(String memberId) {
    mutedConversations.remove(memberId);
    Get.snackbar('Unmuted', 'Notifications enabled for this user.',
        snackPosition: SnackPosition.BOTTOM);
  }

  bool isMuted(String memberId) => mutedConversations.contains(memberId);

  Future<void> showChatNotification(String title, String body, String memberId,
      {String? messageType}) async {
    if (mutedConversations.contains(memberId)) return;
    final member =
        conversations.firstWhereOrNull((m) => m.id.toString() == memberId);

    final notificationTitle = member?.name ?? title;
    String notificationBody;

    switch (messageType) {
      case 'image':
        notificationBody = '📷 Image';
        break;
      case 'video':
        notificationBody = '🎥 Video';
        break;
      case 'file':
        notificationBody = '📎 File';
        break;
      default:
        notificationBody = body.isNotEmpty ? body : 'New message';
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'chat_channel',
      'Chat Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: 'ic_stat_ic_launcher_foreground',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      memberId.hashCode,
      notificationTitle,
      notificationBody,
      platformChannelSpecifics,
      payload: memberId,
    );
  }

  @override
  void onClose() {
    // Clean up any resources
    super.onClose();
  }
}
