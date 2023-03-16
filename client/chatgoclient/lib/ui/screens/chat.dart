import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/chat.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:chatgoclient/ui/widgets/chat/chat_bottom.dart';
import 'package:chatgoclient/ui/widgets/chat/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatefulWidget {
  final ChatPreview chatPreview;
  const ChatScreen({super.key, required this.chatPreview});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(widget.chatPreview.receiverName[0]),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.chatPreview.receiverName),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 2,
            vertical: SizeConfig.blockSizeVertical * 1),
        child: Consumer(
          builder: (context, ref, child) {
            final chatController = ref.watch(chatProvider);
            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatCard(
                            chat: chatController.getDummyChat()[index]);
                      },
                      itemCount: chatController.getDummyChat().length,
                    ),
                  ),
                ),
                const ChatBottom(),
              ],
            );
          },
        ),
      ),
    );
  }
}
