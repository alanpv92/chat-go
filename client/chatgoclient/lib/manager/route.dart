import 'package:chatgoclient/ui/screens/authentication.dart';
import 'package:chatgoclient/ui/screens/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static String authScreen = '/auth';
  static String homeScreen = '/home';
}

class RouteManger {
static  List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(name: Routes.authScreen, page: () =>const AuthenticationScreen(),),
      GetPage(name: Routes.homeScreen, page: () => const HomeScreen(),)
    ];
  }
}
