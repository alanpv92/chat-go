
import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/chat.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = ChangeNotifierProvider((ref) => ChatController());

class ChatController extends BaseController {
  ChatController._();
  static ChatController instance = ChatController._();
  factory ChatController() => instance;

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

  final Chat dummyChat = Chat(
      chatId: '1',
      isReceiverRead: false,
      message: 'hope u are fine',
      receiverId: UserMangementController.instance.user.userId,
      senderId: '2777c110-aff9-4efe-a5b1-6675676c2ba6');
  final Chat dummyChat2 = Chat(
      chatId: '2',
      isReceiverRead: true,
      message: 'i am fine what about u?',
      receiverId: '2777c110-aff9-4efe-a5b1-6675676c2ba6',
      senderId: UserMangementController.instance.user.userId);
  final Chat dummyChat3 = Chat(
      chatId: '3',
      isReceiverRead: false,
      message: 'i am also fine',
      receiverId: UserMangementController.instance.user.userId,
      senderId: '2777c110-aff9-4efe-a5b1-6675676c2ba6');

 List<Chat> getDummyChat() {
    List<Chat> chats = [dummyChat, dummyChat2, dummyChat3];
    return chats;
  }
}
