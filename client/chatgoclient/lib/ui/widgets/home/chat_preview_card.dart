import 'package:chatgoclient/controllers/chat.dart';
import 'package:chatgoclient/ui/screens/chat.dart';
import 'package:chatgoclient/ui/widgets/common/online_status_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ChatPreviewCard extends ConsumerWidget {
  final int index;
  const ChatPreviewCard({super.key,required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatProvider);
    return ListTile(
      onTap: () {
        Get.to(
          () => ChatScreen(
            chatPreview: chatController.currentChatPreviews[index],
          ),
        );
      },
      leading: OnlineStatusAvatar(
        userId: chatController.currentChatPreviews[index].receiverid,
        userName: chatController.currentChatPreviews[index].receiverName,
      ),
      title: Text(
        chatController.currentChatPreviews[index].receiverName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.black),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          chatController.currentChatPreviews[index].lastMessage,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
