import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/user_error.dart';
import 'package:flutter_boilerate_project/shared/data/api/json_parsers/json_parser.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserErrorParser extends JsonParser<UserError>
    with ObjectDecoder<UserError> {
  const UserErrorParser();

  @override
  Future<UserError> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return UserError.fromJson(decoded);
  }
}
