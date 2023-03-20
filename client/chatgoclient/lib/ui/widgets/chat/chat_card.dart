

import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/chat.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  const ChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
  
    return Align(
      alignment: chat.senderId == UserMangementController.instance.user.userId
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: SizedBox(
        width: SizeConfig.safeBlockHorizontal * 35,
        child: Card(
          color: chat.senderId == UserMangementController.instance.user.userId
              ? chat.isReceiverRead
                  ? Colors.green
                  : Colors.grey
              : Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    chat.message,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
