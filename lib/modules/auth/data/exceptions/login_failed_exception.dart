import 'package:flutter_boilerate_project/modules/auth/data/api/json_models/user_error.dart';

class LoginFailedException implements Exception {
  const LoginFailedException({required this.userError});

  final UserError userError;

  @override
  String toString() => userError.toString();
}
