class HiveBox {
  String userBox = 'userbox';
}

class HiveManger with HiveBox {
  HiveManger._();
  static HiveManger instance = HiveManger._();
  factory HiveManger() => instance;
}
