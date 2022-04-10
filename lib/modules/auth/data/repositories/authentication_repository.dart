import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_boilerate_project/modules/auth/data/data_providers/user_api.dart';
import 'package:flutter_boilerate_project/modules/auth/data/exceptions/login_failed_exception.dart';
import 'package:flutter_boilerate_project/modules/auth/data/models/token.dart';
import 'package:flutter_boilerate_project/modules/auth/data/models/user_error.dart';
import 'package:flutter_boilerate_project/shared/data/exceptions/fetch_data_exception.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthenticationRepository {
  const AuthenticationRepository({required UserAPI userAPI})
      : _userAPI = userAPI;

  final UserAPI _userAPI;

  Future<Either<Exception, Token>> login({
    required String username,
    required String password,
  }) async {
    final response =
        await _userAPI.login(username: username, password: password);
    final rawBody = response.body;
    final rawData = jsonDecode(rawBody) as Map<String, dynamic>;
    switch (response.statusCode) {
      case HttpStatus.ok:
        final token = Token.fromJson(rawData);
        return Right(token);
      case HttpStatus.badRequest:
        final userError = UserError.fromJson(rawData);
        return Left(
          LoginFailedException(
            userError: userError,
          ),
        );
      default:
        return const Left(
          FetchDataException(),
        );
    }
  }
}
