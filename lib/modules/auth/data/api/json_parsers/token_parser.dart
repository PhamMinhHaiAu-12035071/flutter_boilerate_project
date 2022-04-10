import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/token.dart';
import 'package:flutter_boilerate_project/shared/data/api/json_parsers/json_parser.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenParser extends JsonParser<Token> with ObjectDecoder<Token> {
  const TokenParser();

  @override
  Future<Token> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return Token.fromJson(decoded);
  }
}
