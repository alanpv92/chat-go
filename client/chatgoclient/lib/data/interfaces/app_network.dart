abstract class AppNetworkInterface {
  Future<void> getRequest();
  Future<void> postRequest();
  Future<void> patchRequest();
  Future<void> deleteRequest();
}
