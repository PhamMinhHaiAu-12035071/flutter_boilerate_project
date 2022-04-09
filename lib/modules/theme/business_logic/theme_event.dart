part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.lightTheme, required this.darkTheme});

  final AppTheme lightTheme;
  final AppTheme darkTheme;

  @override
  List<Object?> get props => [lightTheme, darkTheme];
}
