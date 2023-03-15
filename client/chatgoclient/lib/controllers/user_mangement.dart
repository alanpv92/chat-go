import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/utils/stroage/user_box.dart';
import 'package:get/route_manager.dart';

import '../manager/route.dart';

class UserMangementController {
  UserMangementController._();
  static UserMangementController instance = UserMangementController._();

  factory UserMangementController() => instance;
  final UserBoxStorage _userBoxStorage = UserBoxStorage();
  late User _currentuser;
  late String? _appToken;

  User get user => _currentuser;
  String? get token => _appToken;

  populateAndNavigateOnAuthentication({required User user}) {
    _currentuser = user;
    Get.offAllNamed(Routes.homeScreen);
  }

  initToken() async {
    final tokenFromStorage = await _userBoxStorage.getToken() as String?;
    _appToken = tokenFromStorage;
  }

  storeToken({required String token}) async {
    _appToken = token;
    await _userBoxStorage.storeToken(token: token);
  }
}
