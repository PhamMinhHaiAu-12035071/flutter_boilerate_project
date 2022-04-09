part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.lightTheme = AppTheme.light,
    this.darkTheme = AppTheme.dark,
  });

  final AppTheme lightTheme;
  final AppTheme darkTheme;

  @override
  List<Object> get props => [lightTheme, darkTheme];

  ThemeState copyWith({
    AppTheme? lightTheme,
    AppTheme? darkTheme,
  }) =>
      ThemeState(
        lightTheme: lightTheme ?? AppTheme.light,
        darkTheme: darkTheme ?? AppTheme.dark,
      );
}
