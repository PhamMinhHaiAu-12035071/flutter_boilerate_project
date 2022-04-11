import 'package:dartz/dartz.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/token.dart';

abstract class AuthenticationRepository {
  Future<Either<Exception, Token>> login({
    required String username,
    required String password,
  });

  void stop();
}
