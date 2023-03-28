class ChatRequest {
  final String message;
  final String senderId;
  final String receiverId;
  final String? chatPreviewId;

  ChatRequest(
      {required this.message,
      required this.receiverId,
      required this.senderId,
      this.chatPreviewId,
      });
  getRequestData() =>
      {"message": message, "sender_id": senderId, "receiver_id": receiverId,"chat_preview_id":chatPreviewId};
}
