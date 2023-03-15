class HiveBox {
  String userBox = 'userbox';
  String tokenKey = 'tokenKey';
}

class HiveManger with HiveBox {
  HiveManger._();
  static HiveManger instance = HiveManger._();
  factory HiveManger() => instance;
}
