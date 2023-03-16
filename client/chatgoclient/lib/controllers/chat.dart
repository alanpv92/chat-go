import 'package:chatgoclient/controllers/base.dart';
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
    ChatPreview(receiverName: 'varghese1', receiverid: '2', lastMessage: 'hello'),
  ];
}
