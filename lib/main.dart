import 'package:flutter/material.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/configs/url/url_strategy.dart';
import 'package:flutter_boilerate_project/routers/e_route_information_parser.dart';
import 'package:flutter_boilerate_project/routers/e_router_delegate.dart';
import 'package:flutter_boilerate_project/routers/navigation_cubit.dart';
import 'package:flutter_boilerate_project/routers/page_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ERouteInformationParser get routeInformationParser =>
      ERouteInformationParser();

  ERouterDelegate get routerDelegate =>
      ERouterDelegate(cubit: NavigationCubit([PageConfig(location: '/')]));

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
    );
  }
}
