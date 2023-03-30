
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/ui/screens/chat.dart';
import 'package:chatgoclient/ui/widgets/common/online_status_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';


class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
            () => ChatScreen(chatPreview: ChatPreview.getFromUser(user: user)));
      },
      leading: OnlineStatusAvatar(userId: user.userId,userName: user.userName,),
      title: Text(
        user.userName,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          user.email,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
