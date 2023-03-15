import 'package:chatgoclient/manager/api.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppHasuraConnect {
  AppHasuraConnect._();
  static final AppHasuraConnect instance = AppHasuraConnect._();
  factory AppHasuraConnect() => instance;

  HasuraConnect _hasuraConnect = HasuraConnect(
    ApiManger.graphqlUrl,interceptors: [
      
    ]
  );
}
