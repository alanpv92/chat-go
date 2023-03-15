class AppNetworkException implements Exception {
  final int status;
  final String message;
  AppNetworkException({required this.message, required this.status});
}
