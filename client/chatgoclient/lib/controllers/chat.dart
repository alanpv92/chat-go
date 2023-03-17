import 'dart:developer';

import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/chat.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/network/hasura/chat.dart';
import 'package:chatgoclient/services/network/hasura/users.dart';
import 'package:chatgoclient/utils/custom_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:hasura_connect/hasura_connect.dart';

final chatProvider = ChangeNotifierProvider((ref) => ChatController());

class ChatController extends BaseController {
  ChatController._();
  static ChatController instance = ChatController._();
  factory ChatController() => instance;

  final ChatHasuraService _chatHasuraService = ChatHasuraService();

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

  // final Chat dummyChat = Chat(
  //     chatId: '1',
  //     isReceiverRead: false,
  //     message: 'hope u are fine',
  //     receiverId: UserMangementController.instance.user.userId,
  //     senderId: '2777c110-aff9-4efe-a5b1-6675676c2ba6');
  // final Chat dummyChat2 = Chat(
  //     chatId: '2',
  //     isReceiverRead: true,
  //     message: 'i am fine what about u?',
  //     receiverId: '2777c110-aff9-4efe-a5b1-6675676c2ba6',
  //     senderId: UserMangementController.instance.user.userId);
  // final Chat dummyChat3 = Chat(
  //     chatId: '3',
  //     isReceiverRead: false,
  //     message: 'i am also fine',
  //     receiverId: UserMangementController.instance.user.userId,
  //     senderId: '2777c110-aff9-4efe-a5b1-6675676c2ba6');

  // List<Chat> getDummyChat() {
  //   List<Chat> chats = [dummyChat, dummyChat2, dummyChat3];
  //   return chats;
  // }

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

  closeChatSnapShot() {

    clearCurrentChats();
    chatSnapShot.close();
  }
}
