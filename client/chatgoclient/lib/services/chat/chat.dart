import 'dart:developer';

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/interfaces/chat.dart';
import 'package:chatgoclient/manager/api.dart';
import 'package:chatgoclient/services/network/app_network.dart';
import 'package:dartz/dartz.dart';

class ChatService implements ChatInterface {
  final AppNetwork _appNetwork = AppNetwork();

  @override
  Future<SendChatResponse> sendChat(
      {required Map<String, dynamic> chatData}) async {
   
    final response =
        await _appNetwork.postRequest(path: ApiManger.sendChat, args: chatData);
    return response.fold((l) => left(false), (r) {
      return right(r['id']);
    });
  }
}
