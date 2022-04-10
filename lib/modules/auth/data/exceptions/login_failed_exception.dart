import 'package:flutter_boilerate_project/modules/auth/data/models/user_error.dart';

class LoginFailedException implements Exception {
  const LoginFailedException({required this.userError});

  final UserError userError;

  @override
  String toString() => userError.toString();
}
