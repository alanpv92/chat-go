import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = ChangeNotifierProvider((ref) => ChatController());

class ChatController extends BaseController {
  ChatController._();
  static ChatController instance = ChatController._();
  factory ChatController() => instance;

  final dummyChatPreview = [
    ChatPreview(fromName: 'alan1', fromid: '1', lastMessage: 'hello'),
    ChatPreview(
        fromName: 'paul1',
        fromid: '2',
        lastMessage: 'are comming',
        isLastMessageRead: true),
    ChatPreview(fromName: 'varghese1', fromid: '2', lastMessage: 'hello'),
  ];
}
