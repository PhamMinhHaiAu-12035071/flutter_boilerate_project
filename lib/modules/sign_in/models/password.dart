import 'package:formz/formz.dart';

enum PasswordValidateError {
  empty,
}

class Password extends FormzInput<String, PasswordValidateError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidateError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidateError.empty;
    }
    return null;
  }
}
