import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'package:maritimmuda_connect/app/modules/chat/controllers/chat_controller.dart';

class ChatInputField extends StatefulWidget {
  final Function(String, {String? mediaPath, String? replyTo}) onSend;
  final RxBool isLoading;

  const ChatInputField({
    super.key,
    required this.onSend,
    required this.isLoading,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPickerActive = false;
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_controller.text.trim().isEmpty) return;
    final chatController = Get.find<ChatController>();
    final replyToId = chatController.replyingTo.value?.id;
    widget.onSend(_controller.text, replyTo: replyToId);
    _controller.clear();
    chatController.setReplyingTo(null); 
    _focusNode.requestFocus();
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_isPickerActive) {
      return;
    }

    try {
      _isPickerActive = true;
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        widget.onSend(_controller.text, mediaPath: image.path);
        _controller.clear();
      }
    } catch (e) {
      log('Error picking image: $e');
    } finally {
      _isPickerActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: neutral01Color,
        boxShadow: [
          BoxShadow(
            color: neutral04Color.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(() {
            final controller = Get.find<ChatController>();
            final reply = controller.replyingTo.value;
            if (reply == null) return const SizedBox.shrink();
            return Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: Text(reply.message ?? '',
                          maxLines: 2, overflow: TextOverflow.ellipsis)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => controller.setReplyingTo(null),
                  ),
                ],
              ),
            );
          }),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  onSubmitted: (_) => _handleSubmit(),
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: regulerText14.copyWith(
                        color: neutral04Color.withValues(alpha: 0.3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: neutral04Color.withValues(alpha: 0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: neutral03Color.withValues(alpha: 0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: neutral04Color.withValues(alpha: 0.3)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  maxLines: 4,
                  minLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              Obx(() => IconButton(
                    onPressed: widget.isLoading.value ? null : _handleSubmit,
                    icon: widget.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            Icons.send,
                            color: primaryBlueColor,
                          ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
