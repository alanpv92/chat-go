abstract class AppStorageInterface {
  Future writeData({required String boxName,required String key, required dynamic value});
  Future readData({required String boxName,required String key});
  Future deleteData({required String boxName,required String key});
}
