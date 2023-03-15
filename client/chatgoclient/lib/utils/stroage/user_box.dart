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
    final token = await _appStorage.readData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.tokenKey);
    if (token != null && token is String && token != '') {
      return token;
    }
    return null;
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
    final userId = await _appStorage.readData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userIdKey);
    return userId;
  }

  storeUserName({required String userName}) async {
    await _appStorage.writeData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userNameKey,
        value: userName);
  }

  getUserName() async {
    final userName = _appStorage.readData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userNameKey);
    return userName;
  }

  storeEmail({required String email}) async {
    await _appStorage.writeData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userEmail,
        value: email);
  }

  getEmail() {
    final email = _appStorage.readData(
        boxName: HiveManger.instance.userBox,
        key: HiveManger.instance.userEmail);
    return email;
  }

  getUser() async {
    final String id = await getId();
    final String email = await getEmail();
    final String userName = await getUserName();
    return User(email: email, userId: id, userName: userName);
  }
}
