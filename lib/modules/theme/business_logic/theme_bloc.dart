import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerate_project/modules/theme/constants/enums.dart';
import 'package:injectable/injectable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          const ThemeState(),
        ) {
    on<ThemeChanged>(_onThemeChanged);
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      state.copyWith(lightTheme: event.lightTheme, darkTheme: event.darkTheme),
    );
  }
}
