part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.error = '',
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String error;

  SignInState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    String? error,
  }) =>
      SignInState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [email, password, status, error];
}
