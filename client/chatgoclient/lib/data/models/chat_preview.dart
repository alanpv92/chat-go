// add json serialisable;

class ChatPreview {
  final String fromid;
  final String fromName;
  final String lastMessage;
  bool isLastMessageRead;
  ChatPreview(
      {required this.fromName,
      required this.fromid,
      this.isLastMessageRead = false,
      required this.lastMessage});
}
