import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/chat.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            TextManger.instance.appTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp)),
            const SizedBox(
              width: 15,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.people)),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2,
              vertical: SizeConfig.blockSizeVertical * 1),
          child: Consumer(
            builder: (context, ref, child) {
              final chatController = ref.watch(chatProvider);
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                            chatController.dummyChatPreview[index].receiverName[0]),
                      ),
                      title: Text(
                        chatController.dummyChatPreview[index].receiverName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.black),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          chatController.dummyChatPreview[index].lastMessage,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      trailing: SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 20,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.check,
                              color: chatController
                                      .dummyChatPreview[index].isLastMessageRead
                                  ? Colors.green
                                  : null,
                              size: 20,
                            ),
                          )));
                },
                itemCount: chatController.dummyChatPreview.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            },
          ),
        ));
  }
}
