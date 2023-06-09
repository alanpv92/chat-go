import 'package:chatgoclient/controllers/chat.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:flutter/material.dart';

class ChatBottom extends StatefulWidget {
  final String receiverId;
  final String senderName;
  const ChatBottom(
      {super.key, required this.receiverId, required this.senderName});

  @override
  State<ChatBottom> createState() => _ChatBottomState();
}

class _ChatBottomState extends State<ChatBottom> {
  late TextEditingController chatTextEditingController;

  @override
  void initState() {
    chatTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    chatTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 10, left: 10),
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 8,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        child: TextFormField(
          autocorrect: false,
          controller: chatTextEditingController,
          keyboardType: TextInputType.text,
         
          style: Theme.of(context).textTheme.headlineSmall,
          decoration: InputDecoration(
              hintText: TextManger.instance.sendChatHint,
              suffixIcon: IconButton(
                  onPressed: () {
                    if (chatTextEditingController.text.isEmpty) {
                      return;
                    }

                    ChatController.instance.sendChat(
                        message: chatTextEditingController.text,
                        senderName: widget.senderName,
                        receiverId: widget.receiverId);
                    chatTextEditingController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.send)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
    );
  }
}
