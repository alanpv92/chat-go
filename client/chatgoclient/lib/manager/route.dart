import 'package:chatgoclient/ui/screens/authentication.dart';
import 'package:chatgoclient/ui/screens/home.dart';
import 'package:chatgoclient/ui/screens/search.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static String authScreen = '/auth';
  static String homeScreen = '/home';
  static String chatScreen = '/chat';
  static String searchUsersScreen = '/search/user';
}

class RouteManger {
  static List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(
        name: Routes.authScreen,
        page: () => const AuthenticationScreen(),
      ),
      GetPage(
        name: Routes.homeScreen,
        page: () => const HomeScreen(),
      ),
      GetPage(name: Routes.searchUsersScreen, page: ()=>const SearchUsersScreen())
    ];
  }
}
