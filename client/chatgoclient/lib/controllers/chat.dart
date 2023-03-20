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

  late Snapshot chatPreviewSnapShot;

  final List<Chat> currentOpenChat = [];

  final List<ChatPreview> currentChatPreviews = [];

  Future<Snapshot> setUpChatPreviewSnapShot() async {
    final respone = await _chatHasuraService.getChatPreviewSubscription(
        senderId: UserMangementController.instance.user.userId);
    respone.fold((l) {}, (r) {
      chatPreviewSnapShot = r;
    });
    return chatPreviewSnapShot;
  }

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

  populateCurrentChatPreviews({required Map<String, dynamic> data}) async {
    final List chats = data['data']['chats'];
    currentChatPreviews.clear();
    for (var element in chats) {
      currentChatPreviews.add(ChatPreview(
          receiverName: element['userBySenderId']['user_name'],
          receiverid: element['userBySenderId']['id'],
          isLastMessageRead: element['is_receiver_read'],
          lastMessage: element['message']));
    }
  }

  clearCurrentChats() {
    currentOpenChat.clear();
  }

  sendChat({required String message, required String receiverId}) async {
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
