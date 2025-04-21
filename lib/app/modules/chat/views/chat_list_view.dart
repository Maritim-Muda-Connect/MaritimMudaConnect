import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatListView extends GetView<ChatController> {
  const ChatListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatList is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
