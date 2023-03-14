class AppNetworkException implements Exception {
  final String status;
  final String message;
  AppNetworkException({required this.message, required this.status});
}
