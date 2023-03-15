

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/models/request/login.dart';
import 'package:chatgoclient/data/models/request/register.dart';

abstract class AuthenticationInterface {
  Future<AuthenticationResponse> loginUser({required LoginRequest loginRequest});
  Future<AuthenticationResponse> registerUser({required RegisterRequest registerRequest});
  
}
