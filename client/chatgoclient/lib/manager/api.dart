import 'dart:io';

class AppConfig {
  static String baseURL =
      Platform.isIOS ? 'http://127.0.0.1:5000/' : 'http://10.1.105.137:5000/';
  static String graphQLURL = Platform.isIOS
      ? 'http://localhost:8080/v1/graphql'
      : 'http://10.1.105.137:8080/v1/graphql';
  // static const String baseURL = ;
}

class ApiManger {
  static String apiBaseUrl = AppConfig.baseURL;
  static String graphqlUrl = AppConfig.graphQLURL;
  static String loginUrl = 'auth/login';
  static String registerUrl = 'auth/register';
}
