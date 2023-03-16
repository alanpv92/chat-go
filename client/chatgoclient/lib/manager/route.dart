import 'package:chatgoclient/ui/screens/authentication.dart';
import 'package:chatgoclient/ui/screens/home.dart';
import 'package:chatgoclient/ui/screens/user_search.dart';
import 'package:chatgoclient/ui/screens/users.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static String authScreen = '/auth';
  static String homeScreen = '/home';
  static String chatScreen = '/chat';
  static String usersScreen = '/user';
  static String searchUserScreen = '/search/user';
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
      GetPage(name: Routes.usersScreen, page: () => const UsersScreen()),
      GetPage(name: Routes.searchUserScreen, page: ()=>const UserSearchScreen())
    ];
  }
}
