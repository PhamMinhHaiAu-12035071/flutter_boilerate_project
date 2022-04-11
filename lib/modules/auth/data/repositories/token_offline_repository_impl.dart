import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/token.dart';
import 'package:flutter_boilerate_project/modules/auth/data/repositories/token_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@Named('TokenOfflineRepositoryImpl')
@Singleton(as: TokenRepository)
class TokenOfflineRepositoryImpl implements TokenRepository {
  const TokenOfflineRepositoryImpl(@Named('tokenBoxName') this._tokenBoxName);

  final String _tokenBoxName;

  Box<Token> get box => getIt<HiveInterface>().box<Token>(_tokenBoxName);

  @override
  Future<void> create(Token token) async {
    await box.add(token);
  }

  @override
  void stop() {}
}
