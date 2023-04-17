import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/manager/hive.dart';
import 'package:chatgoclient/services/storage/app_storage.dart';

class UserBoxStorage {
  UserBoxStorage._();
  static UserBoxStorage instance = UserBoxStorage._();
  factory UserBoxStorage() => instance;

  final AppStorage _appStorage = AppStorage();

  storeToken({required String token}) async {
    await _appStorage.writeData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.tokenKey,
        value: token);
  }

  getToken() async {
    try {
      final token = await _appStorage.readData(
          boxName: HiveManger.instance.userBox,
          key: HiveManger.instance.tokenKey);
      if (token != null && token is String && token != '') {
        return token;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  deleteToken() async {
    await _appStorage.deleteData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.tokenKey);
  }

  storeId({required String id}) async {
    await _appStorage.writeData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userIdKey,
        value: id);
  }

  getId() async {
    try {
      final userId = await _appStorage.readData(
          boxName: HiveManger.instance.userBox,
          key: HiveManger.instance.userIdKey);
      return userId;
    } catch (e) {
      rethrow;
    }
  }

  storeUserName({required String userName}) async {
    await _appStorage.writeData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userNameKey,
        value: userName);
  }

  getUserName() async {
    try {
      final userName = _appStorage.readData(
          boxName: HiveManger.instance.userBox,
          key: HiveManger.instance.userNameKey);
      return userName;
    } catch (e) {
      rethrow;
    }
  }

  storeEmail({required String email}) async {
    await _appStorage.writeData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userEmail,
        value: email);
  }

  getEmail() {
    try {
      final email = _appStorage.readData(
          boxName: HiveManger.instance.userBox,
          key: HiveManger.instance.userEmail);
      return email;
    } catch (e) {
      rethrow;
    }
  }

  getUser() async {
    try {
      final String id = await getId();
      final String email = await getEmail();
      final String userName = await getUserName();
      return User(email: email, userId: id, userName: userName);
    } catch (e) {
      rethrow;
    }
  }
}
