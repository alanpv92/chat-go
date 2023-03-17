import 'dart:developer';

import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/chat.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:chatgoclient/data/models/request/chat.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/chat/chat.dart';
import 'package:chatgoclient/services/network/hasura/chat.dart';

import 'package:chatgoclient/utils/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:hasura_connect/hasura_connect.dart';

final chatProvider = ChangeNotifierProvider((ref) => ChatController());

class ChatController extends BaseController {
  ChatController._();
  static ChatController instance = ChatController._();
  factory ChatController() => instance;

  final ChatHasuraService _chatHasuraService = ChatHasuraService();
  final ChatService _chatService = ChatService();

  late Snapshot chatSnapShot;

  final dummyChatPreview = [
    ChatPreview(receiverName: 'alan1', receiverid: '1', lastMessage: 'hello'),
    ChatPreview(
        receiverName: 'paul1',
        receiverid: '2',
        lastMessage: 'are comming',
        isLastMessageRead: true),
    ChatPreview(
        receiverName: 'varghese1', receiverid: '2', lastMessage: 'hello'),
  ];

  final List<Chat> currentOpenChat = [];

  Future<Snapshot> setUpSenderReciverConnection(
      {required String reciverId}) async {
    final response = await _chatHasuraService.getUserReceiverSnapShot(
        senderId: UserMangementController.instance.user.userId,
        receiverId: reciverId);
    response.fold((l) {
      CustomSnackBar.instance
          .showError(errorText: TextManger.instance.randomError);
      Get.back();
    }, (r) {
      chatSnapShot = r;
    });

    return chatSnapShot;
  }

  populateCurrentChat(Map<String, dynamic> data) {
    currentOpenChat.clear();
    final List chats = data['data']['chats'];
    final conChats = chats.map((e) => Chat.fromJson(e)).toList();
    currentOpenChat.addAll(conChats);
  }

  clearCurrentChats() {
    currentOpenChat.clear();
  }

  sendChat({required String message, required String receiverId}) async {
    log('message is $message');
    final dummyChat = Chat(
        chatId: UniqueKey().toString(),
        isReceiverRead: false,
        message: message,
        receiverId: receiverId,
        senderId: UserMangementController.instance.user.userId);
    currentOpenChat.add(dummyChat);
    notifyListeners();
    final response = await _chatService.sendChat(
        chatData: ChatRequest(
                message: message,
                receiverId: receiverId,
                senderId: UserMangementController.instance.user.userId)
            .getRequestData());
    response.fold((l) {
     
      CustomSnackBar.instance.showError(errorText: "could not send message");
      currentOpenChat.remove(dummyChat);
      notifyListeners();
    }, (r) {
      final Chat chat = Chat(
          chatId: r,
          isReceiverRead: dummyChat.isReceiverRead,
          message: dummyChat.message,
          receiverId: dummyChat.receiverId,
          senderId: dummyChat.senderId);
      currentOpenChat.remove(dummyChat);
      currentOpenChat.add(chat);
    });
  }

  closeChatSnapShot() {
    clearCurrentChats();
    chatSnapShot.close();
  }
}
