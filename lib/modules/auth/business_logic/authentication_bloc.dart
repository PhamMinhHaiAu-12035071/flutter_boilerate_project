import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerate_project/modules/auth/constants/enums.dart';
import 'package:flutter_boilerate_project/modules/auth/data/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
      case AuthenticationStatus.authenticated:
        const user = User(username: 'fake', password: 'fake');
        return emit(const AuthenticationState.authenticated(user));
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {}
}
