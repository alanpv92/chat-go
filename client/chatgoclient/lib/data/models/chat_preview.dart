// add json serialisable;

import 'package:chatgoclient/data/models/user.dart';

class ChatPreview {
  final String receiverid;
  final String receiverName;
  final String lastMessage;
  bool isLastMessageRead;
  ChatPreview(
      {required this.receiverName,
      required this.receiverid,
      this.isLastMessageRead = false,
      required this.lastMessage});

  factory ChatPreview.getFromUser({required User user}) => ChatPreview(
      receiverName: user.userName, receiverid: user.userId, lastMessage: '');
}
