import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:flutter/material.dart';

class ChatBottom extends StatefulWidget {
  const ChatBottom({super.key});

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
      height: SizeConfig.safeBlockVertical * 10,
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
          style: Theme.of(context).textTheme.headlineSmall,
          decoration: InputDecoration(
              hintText: TextManger.instance.sendChatHint,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
    );
  }
}
