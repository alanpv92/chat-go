class RegisterRequest {
  final String email;
  final String password;
  final String userName;
  RegisterRequest({required this.email, required this.password,required this.userName});

  getRequestData() => {"email": email, "password": password,"user_name":userName};
}
