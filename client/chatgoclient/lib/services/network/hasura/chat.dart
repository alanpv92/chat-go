import 'dart:developer';

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
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

  Future updateChatPreview({required String userId}) async {
    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.updateReadStatus(userId: userId));
    response.fold((l) {
      log(l.message.toString());
    }, (r) {
      log(r.toString());
    });
    return response;
  }
}
