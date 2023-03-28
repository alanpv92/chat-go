import 'package:chatgoclient/data/exceptions/app_newtork.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

typedef AppNetworkResponse<T>
    = Either<AppNetworkException, Map<String, dynamic>>;

typedef AuthErrorMessage = String;
typedef AuthenticationResponse = Either<AuthErrorMessage, User>;

typedef HasuraResponse = Either<AppNetworkException, Map<String, dynamic>>;

typedef HasuraSubscriptionResponse = Either<AppNetworkException, Snapshot>;

typedef SendChatResponse = Either<bool,String>;
