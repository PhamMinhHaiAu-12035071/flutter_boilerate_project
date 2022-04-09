import 'package:flutter_boilerate_project/modules/home/presentation/home_screen.dart';
import 'package:flutter_boilerate_project/modules/not_found/presentation/not_found_screen.dart';
import 'package:flutter_boilerate_project/modules/sign_in/presentation/sign_in_screen.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';
import 'package:flutter_boilerate_project/routers/page_config.dart';

abstract class Path {
  static const login = '/sign-in';
  static const home = '/';
}

Map<String, EPage Function(Map<String, dynamic>)> _routes = {
  Path.login: (args) => SignInScreen(args: args),
  Path.home: (args) => HomeScreen(args: args),
};

EPage getEPage(PageConfig config) {
  final p = _routes[config.route]?.call(config.args) ??
      NotFoundScreen(args: config.args);
  return p;
}