// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      chatId: json['id'] as String,
      isReceiverRead: json['is_receiver_read'] as bool,
      message: json['message'] as String,
      receiverId: json['receiver_id'] as String,
      senderId: json['sender_id'] as String,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.chatId,
      'receiver_id': instance.receiverId,
      'sender_id': instance.senderId,
      'message': instance.message,
      'is_receiver_read': instance.isReceiverRead,
    };
