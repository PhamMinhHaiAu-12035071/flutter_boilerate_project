import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/token.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/json_parsers/token_parser.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/json_parsers/user_error_parser.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/user_api.dart';
import 'package:flutter_boilerate_project/modules/auth/data/exceptions/login_failed_exception.dart';
import 'package:flutter_boilerate_project/modules/auth/data/repositories/authentication_repository.dart';
import 'package:flutter_boilerate_project/modules/auth/data/repositories/token_repository.dart';
import 'package:flutter_boilerate_project/shared/data/exceptions/fetch_data_exception.dart';
import 'package:injectable/injectable.dart';

@Named('AuthenticationRepositoryImpl')
@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(
    @Named('UserApiImpl') this._userAPI,
    @Named('TokenOfflineRepositoryImpl') this._tokenRepository,
  );

  final UserAPI _userAPI;
  final TokenRepository _tokenRepository;

  @override
  Future<Either<Exception, Token>> login({
    required String username,
    required String password,
  }) async {
    final response =
        await _userAPI.login(username: username, password: password);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final token = await getIt<TokenParser>().parseFromJson(response.data!);
        await _tokenRepository.create(token);
        return Right(token);
      case HttpStatus.badRequest:
        final userError =
            await getIt<UserErrorParser>().parseFromJson(response.data!);
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

  @override
  void stop() {}
}
