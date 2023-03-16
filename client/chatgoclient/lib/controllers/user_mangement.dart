
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

  checkAuthStatus() async {
    if (_appToken != null) {
        _currentuser = await _userBoxStorage.getUser();

      Get.offAllNamed(Routes.homeScreen);
    } else {
  
      Get.offAllNamed(Routes.authScreen);
    }
  }

  populateAndNavigateOnAuthentication({required User user}) async {
    _currentuser = user;
    await _userBoxStorage.storeId(id: user.userId);
    await _userBoxStorage.storeUserName(userName: user.userName);
    await _userBoxStorage.storeEmail(email: user.email);
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

  userMangementControllerDisposer() {
    _appToken = null;
  }
}
