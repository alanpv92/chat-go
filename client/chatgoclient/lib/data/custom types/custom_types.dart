import 'package:chatgoclient/data/exceptions/app_newtork.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:dartz/dartz.dart';

typedef AppNetworkResponse<T>
    = Either<AppNetworkException, Map<String, dynamic>>;

typedef AuthErrorMessage = String;
typedef AuthenticationResponse = Either<AuthErrorMessage,User >;
