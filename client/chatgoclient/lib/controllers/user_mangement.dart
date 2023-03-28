import 'dart:developer';

import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/services/network/hasura/users.dart';
import 'package:chatgoclient/utils/stroage/user_box.dart';
import 'package:get/route_manager.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../manager/route.dart';

class UserMangementController {
  UserMangementController._();
  static UserMangementController instance = UserMangementController._();

  factory UserMangementController() => instance;
  final UserBoxStorage _userBoxStorage = UserBoxStorage();
  final UsersHasuraService _usersHasuraService = UsersHasuraService();
  late User _currentuser;
  late String? _appToken;

  User get user => _currentuser;
  String? get token => _appToken;

  checkAuthStatus() async {
    if (_appToken != null) {
      _currentuser = await _userBoxStorage.getUser();
      return true;
    } else {
      return false;
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

  updateUserOnlineStatus() async {
    final response =
        await _usersHasuraService.addUserStatus(userId: user.userId);
    log(response.toString());
  }

  removeUserOnlineStatus() async {
    final response =
        await _usersHasuraService.removeUserStatus(userId: user.userId);
    log(response.toString());
  }

  Future<Snapshot?> getSingleUserStatusSnapSnot(
      {required String userId}) async {

    final response =
        await _usersHasuraService.watchSingleUserOnlineStatus(userId: userId);
    return response.fold((l) {
      return null;
    }, (r) {
      return r;
    });
  }

  userMangementControllerDisposer() {
    _appToken = null;
  }
}
