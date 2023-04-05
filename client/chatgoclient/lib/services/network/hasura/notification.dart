

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/hasura%20queries/hasura_mutation.dart';
import 'package:chatgoclient/data/hasura%20queries/hasura_query.dart';
import 'package:chatgoclient/services/network/app_hasrua_connect.dart';

class NotificationHasuraService {
  NotificationHasuraService._();
  static NotificationHasuraService instance = NotificationHasuraService._();
  factory NotificationHasuraService() => instance;
  final AppHasuraConnect _appHasuraConnect = AppHasuraConnect();

  Future<HasuraResponse> getUserToken({required String userId}) async {
    final response = await _appHasuraConnect.query(
        query: HasuraQuery.getToken(userId: userId));

    return response;
  }

  Future<HasuraResponse> insertUserNotificationToken(
      {required String userId, required String token}) async {
    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.insertUserNotificationToken(
            token: token, userId: userId));
    return response;
  }

  Future<HasuraResponse> updateUserNotificationToken(
      {required String userId, required String token}) async {
    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.updateUserNotificationToken(
            userId: userId, token: token));
    return response;
  }

  Future<HasuraResponse> removeUserNotificationToken(
      {required String userId}) async {
    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.deleteUserNotificationToken(userId: userId));
    return response;
  }
}
