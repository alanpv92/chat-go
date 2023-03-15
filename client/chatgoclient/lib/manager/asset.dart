class AssetManger {
  AssetManger._();
  static AssetManger instance = AssetManger._();
  factory AssetManger() => instance;

  String transaltions = 'assets/translations';
}
