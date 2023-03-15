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
}
