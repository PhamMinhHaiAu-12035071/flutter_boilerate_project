import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/app_bloc_observer.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/configs/url/url_strategy.dart';
import 'package:flutter_boilerate_project/localization/app_localization_delegate.dart';
import 'package:flutter_boilerate_project/modules/theme/business_logic/theme_bloc.dart';
import 'package:flutter_boilerate_project/modules/theme/constants/app_themes.dart';
import 'package:flutter_boilerate_project/routers/e_route_information_parser.dart';
import 'package:flutter_boilerate_project/routers/e_router_delegate.dart';
import 'package:flutter_boilerate_project/routers/navigation_cubit.dart';
import 'package:flutter_boilerate_project/routers/page_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await configureDependencies();
  await Hive.initFlutter();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: getIt<AppBlocObserver>(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ERouteInformationParser get routeInformationParser =>
      ERouteInformationParser();

  ERouterDelegate get routerDelegate =>
      ERouterDelegate(cubit: NavigationCubit([PageConfig(location: '/')]));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (_, state) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: appThemeData[state.lightTheme],
            darkTheme: appThemeData[state.darkTheme],
            debugShowCheckedModeBanner: false,
            routeInformationParser: routeInformationParser,
            routerDelegate: routerDelegate,
            localizationsDelegates: const [
              AppLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale.fromSubtags(languageCode: 'en'),
              Locale.fromSubtags(languageCode: 'ja'),
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              getIt<Logger>().d('show current locale: $locale');
              getIt<Logger>().d('show support locales: $supportedLocales');
              return null;
            },
          );
        },
      ),
    );
  }
}
