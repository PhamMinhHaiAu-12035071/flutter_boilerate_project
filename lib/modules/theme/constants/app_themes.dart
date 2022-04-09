import 'package:flutter/material.dart';
import 'package:flutter_boilerate_project/modules/theme/constants/enums.dart';

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.orange,
    ),
  ),
  AppTheme.custom: ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepPurple,
    ),
  ),
};
