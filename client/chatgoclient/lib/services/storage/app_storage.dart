import 'package:chatgoclient/data/exceptions/app.dart';

import 'package:chatgoclient/data/interfaces/app_storage.dart';
import 'package:chatgoclient/manager/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppStorage implements AppStorageInterface {
  AppStorage._();
  static AppStorage instance = AppStorage._();
  factory AppStorage() => instance;
  late Box userBox;

  initAppStorage() async {
    try {
      await Hive.initFlutter();
      userBox = await Hive.openBox(HiveManger.instance.userBox);
    } catch (e) {
      throw AppException();
    }
  }

  @override
  Future deleteData({required String boxName, required String key}) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
      } else {
        final value = await Hive.box(boxName).delete(key);
        return value;
      }
    } catch (e) {
      throw AppException();
    }
  }

  @override
  Future readData({required String boxName, required String key}) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
      } else {
        final value = await Hive.box(boxName).get(key);
        return value;
      }
    } catch (e) {
      throw AppException();
    }
  }

  @override
  Future writeData(
      {required String boxName,
      required String key,
      required dynamic value}) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
      } else {
        final data = await Hive.box(boxName).put(key, value);
        return data;
      }
    } catch (e) {
      throw AppException();
    }
  }
}
