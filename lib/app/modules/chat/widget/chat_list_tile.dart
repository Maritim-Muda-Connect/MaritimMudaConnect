import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:maritimmuda_connect/themes.dart';

const _defaultAvatarPath = 'assets/images/default_photo.jpg';

class ChatListTile extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final String lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final VoidCallback onTap;
  final VoidCallback? onLongPress; 
  const ChatListTile({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.lastMessage,
    this.lastMessageTime,
    required this.unreadCount,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: neutral03Color,
        backgroundImage: (photoUrl == null || photoUrl!.isEmpty)
            ? const AssetImage(_defaultAvatarPath)
            : NetworkImage(photoUrl!) as ImageProvider,
      ),
      title: Text(
        name,
        style: semiBoldText16.copyWith(
          color: primaryDarkBlueColor,
        ),
      ),
      subtitle: Text(
        lastMessage,
        style: regulerText12.copyWith(
          color: neutral04Color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (lastMessageTime != null)
            Text(
              timeago.format(lastMessageTime!, locale: 'en_short'),
              style: regulerText10.copyWith(color: neutral04Color),
            ),
          if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: secondaryRedColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unreadCount.toString(),
                style: semiBoldText12.copyWith(color: neutral01Color),
              ),
            ),
        ],
      ),
    );
  }
}
