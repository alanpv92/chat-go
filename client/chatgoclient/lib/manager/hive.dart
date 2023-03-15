class HiveBox {
  String userBox = 'userbox';
  String tokenKey = 'tokenKey';
  String userIdKey = "userIdKey";
  String userNameKey = 'userNameKey';
  String userEmail = "userEmailKey";
}

class HiveManger with HiveBox {
  HiveManger._();
  static HiveManger instance = HiveManger._();
  factory HiveManger() => instance;
}
