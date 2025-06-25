import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/chat/controllers/chat_list_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/member/controllers/member_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/member/views/member_detail_view.dart';
import '../controllers/chat_controller.dart';
import 'package:maritimmuda_connect/app/modules/chat/widget/chat_message_bubble.dart';
import 'package:maritimmuda_connect/app/modules/chat/widget/chat_input_field.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  final String? recipientName;
  final String? recipientPhoto;
  final int? recipientId;

  const ChatView({
    super.key,
    required this.recipientId,
    required this.recipientName,
    required this.recipientPhoto,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();
  final RxBool showScrollToBottom = false.obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;

  ChatController get controller => Get.find<ChatController>();

  List get filteredMessages {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return controller.messages;
    return controller.messages.where((msg) {
      final text = (msg.message ?? '').toLowerCase();
      return msg.messageType == 'text' && text.contains(query) ||
          (msg.messageType == 'image' && text.contains(query));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset <
          _scrollController.position.maxScrollExtent - 100) {
        showScrollToBottom.value = true;
      } else {
        showScrollToBottom.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color.withValues(alpha: 0.99),
      appBar: AppBar(
        backgroundColor: primaryBlueColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: neutral01Color),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => isSearching.value
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search in chat...",
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                style: semiBoldText16.copyWith(color: neutral01Color),
                onChanged: (value) {
                  searchQuery.value = value;
                },
              )
            : GestureDetector(
                onTap: () {
                  final memberController = Get.find<MemberController>();
                  final member =
                      memberController.getMemberById(widget.recipientId!);

                  Get.to(() => MemberDetailView(memberList: member!));
                },
                child: Text(
                  widget.recipientName ?? '',
                  style: semiBoldText16.copyWith(
                    color: neutral01Color,
                  ),
                ),
              )),
        actions: [
          Obx(() => isSearching.value
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    isSearching.value = false;
                    searchQuery.value = '';
                  },
                  tooltip: 'Close',
                )
              : IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    isSearching.value = true;
                  },
                )),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: neutral01Color,
            ),
            onSelected: (value) {
              final chatListController = Get.find<ChatListController>();
              final memberId = widget.recipientId?.toString();

              if (value == 'mute' && memberId != null) {
                if (chatListController.isMuted(memberId)) {
                  chatListController.unmuteConversation(memberId);
                } else {
                  chatListController.muteConversation(memberId);
                }
              } else if (value == 'clear') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Chat'),
                    content: const Text(
                        'Are you sure you want to delete all messages in this chat? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.deleteAllMessagesForCurrentChat();
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
              PopupMenuItem(
                value: 'mute',
                child: Obx(() {
                  final chatListController = Get.find<ChatListController>();
                  final memberId = widget.recipientId?.toString();
                  final isMuted =
                      memberId != null && chatListController.isMuted(memberId);
                  return Text(isMuted ? 'Unmute' : 'Mute');
                }),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Text('Clear Chat'),
              ),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final messages = filteredMessages;

                    if (messages.isEmpty) {
                      return Center(
                        child: Text(
                          isSearching.value && searchQuery.value.isNotEmpty
                              ? 'No messages found.'
                              : 'Belum ada pesan\nMulai percakapan!',
                          style: regulerText14.copyWith(color: neutral04Color),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe =
                            message.senderId == controller.currentUserId;
                        final showDate = index == messages.length - 1 ||
                            message.createdAt?.day !=
                                messages[index + 1].createdAt?.day;

                        return Column(
                          children: [
                            if (showDate)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  DateFormat.yMMMMd()
                                      .format(message.createdAt!),
                                  style: regulerText12.copyWith(
                                      color: neutral03Color),
                                ),
                              ),
                            ChatMessageBubble(
                              id: message.id!,
                              message: message.message ?? '',
                              isMe: isMe,
                              time: message.createdAt,
                              status: message.isRead ?? false ? 'read' : 'sent',
                              messageType: message.messageType,
                              mediaUrl: message.mediaUrl,
                              messageObj: message,
                              replyTo: message.replyTo,
                            ),
                          ],
                        );
                      },
                    );
                  }),
                ),
                ChatInputField(
                  onSend: (String message,
                      {String? mediaPath, String? replyTo}) {
                    return controller.sendMessage(message,
                        mediaPath: mediaPath);
                  },
                  isLoading: controller.isSending,
                ),
              ],
            ),
            Obx(() => showScrollToBottom.value
                ? Positioned(
                    bottom: 80,
                    right: 16,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: neutral01Color,
                      child: Icon(Icons.arrow_downward,
                          color: neutral04Color.withValues(alpha: 0.6)),
                      onPressed: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
