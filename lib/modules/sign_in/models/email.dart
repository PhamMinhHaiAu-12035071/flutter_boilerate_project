import 'package:formz/formz.dart';

enum EmailValidateError {
  empty,
}

class Email extends FormzInput<String, EmailValidateError> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidateError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidateError.empty;
    }
    return null;
  }
}
