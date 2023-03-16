// add json serialisable;

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
}
