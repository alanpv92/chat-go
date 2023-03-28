import 'dart:math';

import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/authentication.dart';
import 'package:chatgoclient/controllers/chat.dart';
import 'package:chatgoclient/manager/route.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/ui/screens/chat.dart';
import 'package:chatgoclient/ui/widgets/common/empty_screen.dart';
import 'package:chatgoclient/ui/widgets/loaders/chat_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            TextManger.instance.appTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.usersScreen);
                },
                icon: const Icon(Icons.search_sharp)),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  AuthenticationController.instance.logoutUser();
                },
                icon: const Icon(Icons.people)),
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
              final chatController = ref.read(chatProvider);
              return FutureBuilder(
                future: chatController.setUpChatPreviewSnapShot(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return StreamBuilder(
                      stream: chatController.chatPreviewSnapShot,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.hasData) {
                          chatController.populateCurrentChatPreviews(
                              data: snapshot.data);
                          return chatController.currentChatPreviews.isEmpty
                              ? const Center(
                                  child: EmptyBox(),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        Get.to(
                                          () => ChatScreen(
                                            chatPreview: chatController
                                                .currentChatPreviews[index],
                                          ),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        child: Text(chatController
                                            .currentChatPreviews[index]
                                            .receiverName[0]),
                                      ),
                                      title: Text(
                                        chatController
                                            .currentChatPreviews[index]
                                            .receiverName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(color: Colors.black),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          chatController
                                              .currentChatPreviews[index]
                                              .lastMessage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount:
                                      chatController.currentChatPreviews.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                );
                        }
                        return const ChatCardShimmerLoader();
                      },
                    );
                  }
                  return const ChatCardShimmerLoader();
                },
              );
            },
          ),
        ));
  }
}
