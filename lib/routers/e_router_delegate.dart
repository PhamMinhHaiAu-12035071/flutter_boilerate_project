import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/auth/business_logic/authentication_bloc.dart';
import 'package:flutter_boilerate_project/modules/auth/constants/enums.dart';
import 'package:flutter_boilerate_project/routers/custom_route_observer.dart';
import 'package:flutter_boilerate_project/routers/custom_transition_delegate.dart';
import 'package:flutter_boilerate_project/routers/navigation_cubit.dart';
import 'package:flutter_boilerate_project/routers/navigation_stack.dart';
import 'package:flutter_boilerate_project/routers/page_config.dart';
import 'package:flutter_boilerate_project/routers/routes.dart';

class ERouterDelegate extends RouterDelegate<PageConfig>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<PageConfig>,
        WidgetsBindingObserver {
  ERouterDelegate({required NavigationCubit cubit}) : _cubit = cubit;

  final NavigationCubit _cubit;

  final heroC = HeroController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _cubit),
        BlocProvider(create: (_) => getIt<AuthenticationBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          _listenForNavigation(),
          _listenForAuth(),
        ],
        child: BlocBuilder<NavigationCubit, NavigationStack>(
          builder: (context, stack) {
            return Navigator(
              pages: stack.pages,
              key: navigatorKey,
              onPopPage: _onPopPage,
              observers: [CustomRouteObserver(), heroC],
              transitionDelegate: const CustomTransitionDelegate(),
            );
          },
        ),
      ),
    );
  }

  ///here we handle back buttons
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (_cubit.canPop()) {
      _cubit.pop();
      return true;
    } else {
      return false;
    }
  }

  BlocListener _listenForNavigation() {
    return BlocListener<NavigationCubit, NavigationStack>(
      listener: (_, state) {
        notifyListeners();
      },
    );
  }

  BlocListener _listenForAuth() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        switch (state.status) {
          case AuthenticationStatus.unknown:
            break;
          case AuthenticationStatus.authenticated:
            _cubit.clearAndPush(Path.home);
            break;
          case AuthenticationStatus.unauthenticated:
            _cubit.clearAndPush(Path.login);
            break;
        }
        notifyListeners();
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    if (_cubit.isBackHistory(configuration) && _cubit.canPop()) {
      _cubit.pop();
    }
    _cubit.push(configuration.route, configuration.args);
  }

  ///called by router when it detects it may have changed because of a rebuild
  ///necessary for backward and forward buttons to work properly
  @override
  PageConfig? get currentConfiguration => _cubit.state.last;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
