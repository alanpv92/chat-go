//add json serializable

class Chat {
  final String chatId;
  final String receiverId;
  final String senderId;
  final String message;
  final bool isReceiverRead;
  Chat(
      {required this.chatId,
      required this.isReceiverRead,
      required this.message,
      required this.receiverId,
      required this.senderId});
}
