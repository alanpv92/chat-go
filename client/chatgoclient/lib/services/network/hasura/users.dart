import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/hasura%20queries/hasura_mutation.dart';

import 'package:chatgoclient/data/hasura%20queries/hasura_query.dart';
import 'package:chatgoclient/data/hasura%20queries/subscriptions.dart';
import 'package:chatgoclient/services/network/app_hasrua_connect.dart';
import 'package:dartz/dartz.dart';

class UsersHasuraService {
  UsersHasuraService._();
  static UsersHasuraService instance = UsersHasuraService._();
  factory UsersHasuraService() => instance;

  final AppHasuraConnect _appHasuraConnect = AppHasuraConnect();

  Future<HasuraResponse> getAllUsers(
      {required int offset, int limit = 10}) async {
    final response = await _appHasuraConnect.query(
        query: HasuraQuery.getAllUsers(limit: limit, offset: offset));

    return response;
  }

  Future<HasuraResponse> getUsersBySearchQuery(
      {required String searchQuery}) async {
    if (searchQuery == '') {
      return right({});
    }
    final response = await _appHasuraConnect.query(
        query: HasuraQuery.getUserBySearchQuery(searchQuery: searchQuery));
    return response;
  }

  Future<HasuraResponse> addUserStatus({required String userId}) async {
    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.addUserStatus(userId: userId));
    return response;
  }

  Future<HasuraResponse> removeUserStatus({required String userId}) async {
    final response = await _appHasuraConnect.mutation(
        query: HasuraMutation.removeUserStatus(userId: userId));
    return response;
  }
    Future<HasuraSubscriptionResponse> watchSingleUserOnlineStatus(
      {required String userId}) async {
    final response = _appHasuraConnect.subscription(
        query: HasuraSubscriptions.getSingleUserOnlineSnap(userId: userId));
    return response;    
  }
}
