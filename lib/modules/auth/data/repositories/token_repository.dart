import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/token.dart';

abstract class TokenRepository {
  Future<void> create(Token token);
  Future<List<Token>> getAll();
  Future<int> getSizes();
}
