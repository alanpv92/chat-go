class ChatRequest {
  final String message;
  final String senderId;
  final String receiverId;

  ChatRequest(
      {required this.message,
      required this.receiverId,
      required this.senderId});
  getRequestData() =>
      {"message": message, "sender_id": senderId, "receiver_id": receiverId};
}
