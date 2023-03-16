
import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/hasura%20queries/hasura_query.dart';
import 'package:chatgoclient/services/network/app_hasrua_connect.dart';

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
}
