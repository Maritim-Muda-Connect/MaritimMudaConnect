import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/home/member/views/member_detail_view.dart';
import 'package:maritimmuda_connect/app/routes/app_pages.dart';
import '../controllers/chat_list_controller.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:maritimmuda_connect/app/modules/chat/widget/chat_list_tile.dart';

class ChatListView extends GetView<ChatListController> with RouteAware {
  const ChatListView({super.key});

  @override
  void didPopNext() {
    controller.onViewOpened();
  }

  @override
  void didPush() {
    controller.onViewOpened();
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = false.obs;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'newChat',
        backgroundColor: primaryBlueColor,
        onPressed: () => Get.toNamed(Routes.MEMBER),
        child: Icon(
          Icons.add_comment,
          color: neutral01Color,
        ),
      ),
      backgroundColor: neutral02Color,
      appBar: AppBar(
        title: Obx(() => isSearching.value
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search conversations...",
                  border: InputBorder.none,
                ),
                style: semiBoldText16.copyWith(color: neutral01Color),
                onChanged: (value) {
                  controller.searchQuery.value = value;
                },
              )
            : Text(
                'Messages',
                style: semiBoldText16.copyWith(color: neutral01Color),
              )),
        backgroundColor: primaryBlueColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: neutral01Color),
          onPressed: () {
            if (isSearching.value) {
              isSearching.value = false;
              controller.searchQuery.value = '';
            } else {
              Get.back();
            }
          },
        ),
        actions: [
          Obx(() => isSearching.value
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    isSearching.value = false;
                    controller.searchQuery.value = '';
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    isSearching.value = true;
                  },
                )),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: neutral01Color),
            onSelected: (value) {
              if (value == 'mark_read') {
                controller.markAllAsRead();
              }
              if (value == 'delete_all') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete All?'),
                    content: const Text(
                        'Apakah anda yakin ingin menghapus semua percakapan?.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(), // Cancel
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.deleteAllConversations();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'mark_read',
                child: Text('Mark All as Read'),
              ),
              const PopupMenuItem<String>(
                value: 'delete_all',
                child: Text('Delete All Conversations'),
              ),
            ],
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.conversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: neutral04Color,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tidak ada percakapan yang ditemukan',
                  style: regulerText14.copyWith(color: neutral04Color),
                ),
              ],
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
            final lastMessage = controller.lastMessages[member.id.toString()];
            final unreadCount =
                controller.unreadCounts[member.id.toString()] ?? 0;

            return ChatListTile(
              name: member.name ?? '',
              photoUrl: member.photoLink,
              lastMessage: controller.getLastMessageText(
                  controller.lastMessages[member.id.toString()]),
              lastMessageTime: lastMessage?.createdAt,
              unreadCount: unreadCount,
              onTap: () => controller.navigateToChat(member),
              onLongPress: () async {
                final result = await showModalBottomSheet<String>(
                  context: context,
                  builder: (context) => SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(
                            controller.isMuted(member.id.toString())
                                ? Icons.volume_up
                                : Icons.volume_off,
                          ),
                          title: Text(controller.isMuted(member.id.toString())
                              ? 'Unmute'
                              : 'Mute'),
                          onTap: () => Navigator.pop(context, 'mute'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.red),
                          title: const Text('Delete Conversation',
                              style: TextStyle(color: Colors.red)),
                          onTap: () => Navigator.pop(context, 'delete'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: const Text('View Profile'),
                          onTap: () => Navigator.pop(context, 'profile'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.cancel),
                          title: const Text('Cancel'),
                          onTap: () => Navigator.pop(context, 'cancel'),
                        ),
                      ],
                    ),
                  ),
                );
                if (result == 'mute') {
                  if (controller.isMuted(member.id.toString())) {
                    controller.unmuteConversation(member.id.toString());
                  } else {
                    controller.muteConversation(member.id.toString());
                  }
                }
                if (result == 'delete') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Conversation'),
                      content: const Text(
                          'Apakah anda yakin ingin menghapus percakapan ini?'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.deleteConversation(member.id.toString());
                            Navigator.of(context)
                                .pop(); 
                          },
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                }
                if (result == 'profile') {
                  Get.to(() => MemberDetailView(memberList: member));
                }
              },
            );
          },
        );
      }),
    );
  }
}
