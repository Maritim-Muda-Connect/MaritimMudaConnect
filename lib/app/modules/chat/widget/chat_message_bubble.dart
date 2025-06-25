import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/response/chat_message_response.dart';
import 'package:maritimmuda_connect/app/modules/chat/widget/recipient_picker_view.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:maritimmuda_connect/app/modules/product/widgets/custom_image_view.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/chat/controllers/chat_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:share_plus/share_plus.dart';

class ChatMessageBubble extends StatelessWidget {
  final String? id;
  final String message;
  final bool isMe;
  final DateTime? time;
  final String status;
  final String? messageType;
  final String? mediaUrl;
  final String? replyTo;
  final ChatMessageResponse? messageObj;

  const ChatMessageBubble({
    this.id,
    super.key,
    required this.message,
    required this.isMe,
    this.time,
    required this.status,
    this.messageType = 'text',
    this.mediaUrl,
    this.replyTo,
    this.messageObj,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? 40 : 8,
        right: isMe ? 8 : 40,
        top: 2,
        bottom: 2,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                    minWidth: 0,
                  ),
                  child: GestureDetector(
                    onLongPress: () async {
                      final result = await showModalBottomSheet<String>(
                        context: context,
                        builder: (context) => SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (final emoji in [
                                      '👍',
                                      '❤️',
                                      '😂',
                                      '😮',
                                      '😢'
                                    ])
                                      IconButton(
                                        icon: Text(emoji,
                                            style:
                                                const TextStyle(fontSize: 24)),
                                        onPressed: () =>
                                            Navigator.pop(context, emoji),
                                      ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.reply),
                                title: const Text('Reply'),
                                onTap: () => Navigator.pop(context, 'reply'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.copy),
                                title: const Text('Copy'),
                                onTap: () => Navigator.pop(context, 'copy'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.shortcut),
                                title: const Text('Forward'),
                                onTap: () => Navigator.pop(context, 'forward'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.share),
                                title: const Text('Share'),
                                onTap: () => Navigator.pop(context, 'share'),
                              ),
                              ListTile(
                                leading:
                                    const Icon(Icons.delete, color: Colors.red),
                                title: const Text('Delete',
                                    style: TextStyle(color: Colors.red)),
                                onTap: () => Navigator.pop(context, 'delete'),
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
                      if (['👍', '❤️', '😂', '😮', '😢'].contains(result)) {
                        controller.addReaction(id!, result!);
                      }
                      if (result == 'reply') {
                        controller.setReplyingTo(messageObj);
                      }
                      if (result == 'copy') {
                        Clipboard.setData(ClipboardData(text: message));
                        Get.snackbar(
                          'Copied',
                          'Message copied to clipboard',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                      if (result == 'forward') {
                        Get.to(() => RecipientPickerView(
                                messageToForward: ChatMessageResponse(
                              id: id,
                              message: message,
                              messageType: messageType,
                              mediaUrl: mediaUrl,
                            )));
                      }
                      if (result == 'delete') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Message'),
                            content: const Text(
                                'Apakah Anda yakin ingin menghapus pesan ini?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); 
                                  controller.deleteMessage(id!);
                                },
                                child: const Text('Delete',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      }
                      if (result == 'share') {
                        if (messageType == 'image' && mediaUrl != null) {
                          await Share.shareXFiles([XFile(mediaUrl!)]);
                        } else if (message.isNotEmpty) {
                          Share.share(message);
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: messageType == 'image' ? 8 : 12,
                        vertical: messageType == 'image' ? 8 : 10,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? primaryBlueColor : neutral01Color,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (replyTo != null)
                            Builder(
                              builder: (context) {
                                final controller = Get.find<ChatController>();
                                final repliedMessage = controller.messages.firstWhereOrNull((m) => m.id == replyTo);
                                if (repliedMessage == null) return const SizedBox.shrink();
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 4),
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 4,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: isMe ? primaryBlueColor : Colors.green,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          repliedMessage.message?.isNotEmpty == true
                                              ? repliedMessage.message!
                                              : '[Deleted]',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (messageType == 'image' && mediaUrl != null) ...[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ZoomableImageView(
                                      imageUrl: mediaUrl!,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                  File(mediaUrl!),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 180,
                                    height: 180,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            if (message.isNotEmpty) const SizedBox(height: 8),
                          ],
                          if (message.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: SelectableText.rich(
                                TextSpan(
                                  children: _linkify(message,
                                      isMe ? neutral01Color : neutral04Color),
                                ),
                                style: regulerText14.copyWith(
                                  color: isMe ? neutral01Color : neutral04Color,
                                ),
                              ),
                            ),
                          if ((messageObj?.reactions?.isNotEmpty ?? false))
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Wrap(
                                spacing: 4,
                                children: messageObj!.reactions!.entries
                                    .map((entry) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                              '${entry.key} ${entry.value > 1 ? entry.value : ''}'),
                                        ))
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time != null ? DateFormat('HH:mm').format(time!) : '',
                style: regulerText11.copyWith(
                  color: isMe
                      ? neutral04Color.withValues(alpha: 0.6)
                      : neutral04Color.withValues(alpha: 0.6),
                ),
              ),
              if (isMe) ...[
                const SizedBox(width: 4),
                Icon(
                  status == 'read' ? Icons.done_all : Icons.done,
                  size: 15,
                  color: status == 'read'
                      ? primaryBlueColor
                      : neutral04Color.withValues(alpha: 0.6),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  List<InlineSpan> _linkify(String message, Color color) {
    final urlRegex = RegExp(r'(https?:\/\/[^\s]+)');
    final spans = <InlineSpan>[];
    int start = 0;

    urlRegex.allMatches(message).forEach((match) {
      if (match.start > start) {
        spans.add(TextSpan(text: message.substring(start, match.start)));
      }
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: TextStyle(
            color: primaryDarkBlueColor,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.platformDefault);
              }
            },
        ),
      );
      start = match.end;
    });
    if (start < message.length) {
      spans.add(TextSpan(text: message.substring(start)));
    }
    return spans;
  }
}
