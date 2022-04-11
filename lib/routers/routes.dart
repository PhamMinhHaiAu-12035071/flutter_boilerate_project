import 'package:flutter_boilerate_project/modules/animation_demo/presentation/animation_demo_screen.dart';
import 'package:flutter_boilerate_project/modules/detail_product/presentation/detail_product_screen.dart';
import 'package:flutter_boilerate_project/modules/home/presentation/home_screen.dart';
import 'package:flutter_boilerate_project/modules/not_found/presentation/not_found_screen.dart';
import 'package:flutter_boilerate_project/modules/sign_in/presentation/sign_in_screen.dart';
import 'package:flutter_boilerate_project/modules/splash_screen/presentation/splash_screen.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';
import 'package:flutter_boilerate_project/routers/page_config.dart';

abstract class Path {
  static const splashScreen = '/splash-screen';
  static const login = '/sign-in';
  static const home = '/';
  static const detailProduct = '/detail-product';
  static const animationDemo = '/animation-demo';
}

Map<String, EPage Function(Map<String, dynamic>)> _routes = {
  Path.splashScreen: (args) => SplashScreen(args: args),
  Path.login: (args) => SignInScreen(args: args),
  Path.home: (args) => HomeScreen(args: args),
  Path.detailProduct: (args) => DetailProductScreen(args: args),
  Path.animationDemo: (args) => AnimationDemoScreen(args: args),
};

EPage getEPage(PageConfig config) {
  final p = _routes[config.route]?.call(config.args) ??
      NotFoundScreen(args: config.args);
  return p;
}
