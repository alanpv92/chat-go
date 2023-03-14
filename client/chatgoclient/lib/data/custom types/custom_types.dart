import 'package:chatgoclient/data/exceptions/app_newtork.dart';
import 'package:dartz/dartz.dart';

typedef AppNetworkResponse<T> = Either<AppNetworkException, Map<String,dynamic>>;
