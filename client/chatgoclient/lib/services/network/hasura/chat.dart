import 'dart:developer';

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/hasura%20queries/hasura_query.dart';
import 'package:chatgoclient/data/hasura%20queries/subscriptions.dart';
import 'package:chatgoclient/services/network/app_hasrua_connect.dart';

import '../../../data/hasura queries/hasura_mutation.dart';

class ChatHasuraService {
  ChatHasuraService._();
  static ChatHasuraService instance = ChatHasuraService._();
  factory ChatHasuraService() => instance;

  final AppHasuraConnect _appHasuraConnect = AppHasuraConnect();

  Future<HasuraSubscriptionResponse> getUserReceiverSnapShot(
      {required String senderId, required String receiverId}) async {
    final response = await _appHasuraConnect.subscription(
        query: HasuraSubscriptions.getUserSenderSubscription(
            senderId: senderId, receiverId: receiverId));
    return response;
  }

  Future<HasuraSubscriptionResponse> getChatPreviewSubscription(
      {required String senderId}) async {
    final response = await _appHasuraConnect.subscription(
        query:
            HasuraSubscriptions.getChatPreviewSubScription(senderId: senderId));
    return response;
  }

  Future updateChatPreview(
      {required String senderId, required String receiverId}) async {

    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.updateReadStatus(
            receiverId: receiverId, senderId: senderId));
    return response;
  }

  Future<HasuraResponse> getAllUserChats(
      {required String senderId, required String receiverId}) async {
    final response = await _appHasuraConnect.query(
        query: HasuraQuery.getUserChat(
            senderId: senderId, receiverId: receiverId));
    return response;
  }

  Future<HasuraResponse> getUserChatCount(
      {required String senderId, required String receiverId}) async {
    final response = await _appHasuraConnect.query(
        query: HasuraQuery.getUserChatCount(
            senderId: senderId, receiverId: receiverId));
    return response;
  }

  Future<HasuraResponse> getLatestUserChats(
      {required String senderId,
      required String receiverId,
      required int limit}) async {
    final responose = await _appHasuraConnect.query(
        query: HasuraQuery.getUserLatestChats(
            senderId: senderId, receiverId: receiverId, limit: limit));
    return responose;
  }

  Future<HasuraResponse> updateSingleChatStatus(
      {required String chatId}) async {

    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.updateSingleChatByPk(chatId: chatId));
    return response;
  }
}
