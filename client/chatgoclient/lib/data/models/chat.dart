import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  @JsonKey(name: 'id')
  final String chatId;
  @JsonKey(name: 'receiver_id')
  final String receiverId;
  @JsonKey(name: 'sender_id')
  final String senderId;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'is_receiver_read')
  final bool isReceiverRead;
  Chat(
      {required this.chatId,
      required this.isReceiverRead,
      required this.message,
      required this.receiverId,
      required this.senderId});
  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  @override
  bool operator ==(Object other) {
    return (other is Chat) && other.chatId == chatId;
  }

  @override
  int get hashCode => Object.hashAll([chatId]);
}
