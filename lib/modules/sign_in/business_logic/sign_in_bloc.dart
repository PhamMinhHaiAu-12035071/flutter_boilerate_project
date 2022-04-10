import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerate_project/modules/auth/data/exceptions/login_failed_exception.dart';
import 'package:flutter_boilerate_project/modules/auth/data/models/token.dart';
import 'package:flutter_boilerate_project/modules/auth/data/repositories/authentication_repository.dart';
import 'package:flutter_boilerate_project/modules/sign_in/models/models.dart';
import 'package:flutter_boilerate_project/shared/data/exceptions/fetch_data_exception.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@singleton
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) {
    final email = Email.dirty(event.email);
    final status = Formz.validate([state.password, email]);
    emit(
      state.copyWith(
        email: email,
        status: status,
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);
    final status = Formz.validate([password, state.email]);
    emit(
      state.copyWith(
        password: password,
        status: status,
      ),
    );
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final result = await _authenticationRepository.login(
        username: state.email.value,
        password: state.password.value,
      );
      result.fold((Exception exception) {
        if (exception is LoginFailedException) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              error: exception.toString(),
            ),
          );
        } else if (exception is FetchDataException) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              error: exception.toString(),
            ),
          );
        }
      }, (Token token) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess, error: ''));
      });
    }
  }
}
