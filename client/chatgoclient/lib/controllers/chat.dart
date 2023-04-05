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

  final List<ChatPreview> currentChatPreviews = [];

  late ScrollController _scrollController;

  final Map<String, List<Chat>> userChats = {};

  ScrollController get scrollController => _scrollController;

  initScrollController() {
    _scrollController = ScrollController();
  }

  disposeScrollController() {
    _scrollController.dispose();
  }

  scrollDown() {
    Future.delayed(
      Duration.zero,
      () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        }
      },
    );
  }

  Future setUpChatPreviewSnapShot() async {
    final respone = await _chatHasuraService.getChatPreviewSubscription(
        senderId: UserMangementController.instance.user.userId);

    respone.fold((l) {
      log(l.toString());
    }, (r) {
      chatPreviewSnapShot = r;
    });
  }

  Future setUpSenderReciverConnection({required String reciverId}) async {
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
  }

  handleIncomingChat(
      {required Map<String, dynamic> incommingChat,
      required String reciverId}) {
    if (incommingChat == {} ||
        incommingChat['data'] == {} ||
        incommingChat['data']['chats'].isEmpty) {
      return;
    }
    final chat = Chat.fromJson(incommingChat['data']['chats'][0]);
    if (chat.isReceiverRead) {
      final index = userChats[reciverId]?.indexOf(chat);
      if (index != null && index != -1) {
        userChats[reciverId]?[index] = chat;
      }
      updateChatReadStatus(receiverid: reciverId);
      return;
    }
    final lastChatId = userChats[reciverId]?.last.chatId;
    if (lastChatId != null && lastChatId == chat.chatId) {
      return;
    }

    userChats[reciverId]?.add(chat);
    if (chat.receiverId == UserMangementController.instance.user.userId) {
      _chatHasuraService.updateSingleChatStatus(chatId: chat.chatId);
    }
  }

  updateChatReadStatus({required String receiverid}) {
    if (userChats[receiverid] == null) {
      return;
    }
    for (int i = 0; i < userChats[receiverid]!.length; i++) {
      final currentChat = userChats[receiverid]![i];
      userChats[receiverid]![i] = Chat(
          chatId: currentChat.chatId,
          isReceiverRead: true,
          message: currentChat.message,
          receiverId: currentChat.receiverId,
          senderId: currentChat.senderId);
    }
  }

  Future populateInitialChats({required String reciverId}) async {
    if (userChats[reciverId] != null) {
      final chatCount = await _chatHasuraService.getUserChatCount(
          senderId: UserMangementController.instance.user.userId,
          receiverId: reciverId);
      await chatCount.fold((l) {
        CustomSnackBar.instance
            .showError(errorText: TextManger.instance.chatCountError);
        return;
      }, (r) async {
        final count = r['chats_aggregate']['aggregate']['count'];
        if (userChats[reciverId]!.length < count) {
          final numberOfDataToFecth = count - userChats[reciverId]!.length;
          final reponse = await _chatHasuraService.getLatestUserChats(
              senderId: UserMangementController.instance.user.userId,
              receiverId: reciverId,
              limit: numberOfDataToFecth);

          reponse.fold((l) {
            CustomSnackBar.instance
                .showError(errorText: TextManger.instance.chatCountError);
            return;
          }, (r) {
            final List chatData = r['chats'];
            final conChats = chatData.map((e) => Chat.fromJson(e)).toList();
            userChats[reciverId]!.addAll(conChats.reversed);
          });
        }
      });
    } else {
      final response = await _chatHasuraService.getAllUserChats(
          senderId: UserMangementController.instance.user.userId,
          receiverId: reciverId);
      response.fold((l) {
        CustomSnackBar.instance
            .showError(errorText: TextManger.instance.randomError);
        Get.back();
        return;
      }, (r) {
        final List chatData = r['chats'];
        final conChats = chatData.map((e) => Chat.fromJson(e)).toList();
        userChats[reciverId] = [];
        userChats[reciverId]!.addAll(conChats);
      });
    }
    await setUpSenderReciverConnection(reciverId: reciverId);
  }

  populateCurrentChatPreviews({required Map<String, dynamic> data}) async {
    final List chats = data['data']['chatpreview'];
    currentChatPreviews.clear();
    for (var element in chats) {
      final chatDetails = element['chat'];
      final String lastMessage = chatDetails['message'];
      final String receiverId = chatDetails['receiver_id'];
      final String senderId = chatDetails['sender_id'];
      final bool isLastMessageRead = chatDetails['is_receiver_read'];
      late final String userName;
      late final String chatPreviewReceiverId;
      if (receiverId == UserMangementController.instance.user.userId) {
        userName = chatDetails['userBySenderId']['user_name'];
        chatPreviewReceiverId = senderId;
      } else {
        userName = chatDetails['user']['user_name'];
        chatPreviewReceiverId = receiverId;
      }
      currentChatPreviews.add(ChatPreview(
        id: element['id'],
        isLastMessageRead: isLastMessageRead,
        receiverName: userName,
        receiverid: chatPreviewReceiverId,
        lastMessage: lastMessage,
      ));
    }
  }

  sendChat(
      {required String message,
      required String receiverId,
      required String senderName}) async {
    final dummyChat = Chat(
        chatId: UniqueKey().toString(),
        isReceiverRead: false,
        message: message,
        receiverId: receiverId,
        senderId: UserMangementController.instance.user.userId);
    if (userChats[receiverId] == null) {
      userChats[receiverId] = [];
    }
    userChats[receiverId]!.add(dummyChat);
    notifyListeners();
    final response = await _chatService.sendChat(
        chatData: ChatRequest(
                message: message,
                receiverId: receiverId,
                senderName: senderName,
                chatPreviewId: getChatPreview(receiverId: receiverId)?.id,
                senderId: UserMangementController.instance.user.userId)
            .getRequestData());

    response.fold((l) {
      CustomSnackBar.instance.showError(errorText: "could not send message");
      userChats[receiverId]!.remove(dummyChat);
      notifyListeners();
    }, (r) {
      final Chat chat = Chat(
          chatId: r,
          isReceiverRead: dummyChat.isReceiverRead,
          message: dummyChat.message,
          receiverId: dummyChat.receiverId,
          senderId: dummyChat.senderId);
      userChats[receiverId]!.remove(dummyChat);
      userChats[receiverId]!.add(chat);
      scrollDown();
    });
  }

  Future updateReadStatus({required String receiverId}) async {
    _chatHasuraService.updateChatPreview(
        receiverId: UserMangementController.instance.user.userId,
        senderId: receiverId);
  }

  ChatPreview? getChatPreview({required String receiverId}) {
    final chatPreview = currentChatPreviews
        .where((element) => element.receiverid == receiverId)
        .toList();
    if (chatPreview.isNotEmpty) {
      return chatPreview[0];
    }
    return null;
  }

  closeChatSnapShot() {
    chatSnapShot.close();
  }

  chatControllerDispose() {
    userChats.clear();
    currentChatPreviews.clear();
  }
}
