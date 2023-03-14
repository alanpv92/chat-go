import 'package:chatgoclient/data/models/user.dart';
import 'package:get/route_manager.dart';

import '../manager/route.dart';

class UserMangementController {
  UserMangementController._();
  static UserMangementController instance = UserMangementController._();
  factory UserMangementController() => instance;
  late User currentuser;

  populateAndNavigateOnAuthentication({required User user}) {
    currentuser = user;
    Get.offAllNamed(Routes.homeScreen);
  }
}
