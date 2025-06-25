import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/chat_message_response.dart';
import 'package:maritimmuda_connect/app/modules/chat/controllers/chat_controller.dart';
import '../controllers/chat_list_controller.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:maritimmuda_connect/app/data/models/request/chat_message_request.dart';

class RecipientPickerView extends StatelessWidget {
  final ChatMessageResponse messageToForward;

  const RecipientPickerView({super.key, required this.messageToForward});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatListController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forward to...'),
        backgroundColor: primaryBlueColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: neutral01Color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (controller.conversations.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada anggota yang dapat diteruskan\n Hubungi anggota terlebih dahulu',
              style: regulerText14.copyWith(color: neutral04Color),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.filteredConversations.length,
          separatorBuilder: (context, index) => Divider(
            color: neutral03Color,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final member = controller.filteredConversations[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: member.photoLink != null
                    ? NetworkImage(member.photoLink!)
                    : null,
                child:
                    member.photoLink == null ? const Icon(Icons.person) : null,
              ),
              title: Text(member.name ?? ''),
              onTap: () async {
                await controller.chatService.sendMessage(
                  ChatMessageRequest(
                    recipientId: member.id!,
                    message: messageToForward.message ?? '',
                    messageType: messageToForward.messageType ?? 'text',
                  ),
                  messageToForward.mediaUrl,
                );
                if (Get.isRegistered<ChatController>()) {
                  final chatController = Get.find<ChatController>();
                  if (chatController.recipientId == member.id) {
                    await chatController.loadMessages();
                  }
                }
                Get.back();
                Get.snackbar(
                  snackPosition: SnackPosition.BOTTOM,
                  'Forwarded',
                  'Message forwarded to ${member.name}',
                );
              },
            );
          },
        );
      }),
    );
  }
}
