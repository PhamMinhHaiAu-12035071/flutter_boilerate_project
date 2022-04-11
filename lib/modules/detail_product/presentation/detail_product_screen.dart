import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';
import 'package:flutter_boilerate_project/routers/navigation_cubit.dart';
import 'package:flutter_boilerate_project/routers/routes.dart';

class DetailProductScreen extends EPage {
  const DetailProductScreen({required Map<String, dynamic> args})
      : super(args: args);

  @override
  Widget build(BuildContext context) {
    return const DetailProductView();
  }

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      transitionDuration: Duration(milliseconds: transitionDuration),
      reverseTransitionDuration:
          Duration(milliseconds: reverseTransitionDuration),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> animation2,
      ) =>
          build(context),
    );
  }
}

class DetailProductView extends StatelessWidget {
  const DetailProductView({Key? key}) : super(key: key);

  void _onNavigateToAnimationDemoPage(BuildContext context) =>
      context.read<NavigationCubit>().push(Path.animationDemo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: GestureDetector(
            onTap: () => _onNavigateToAnimationDemoPage(context),
            child: Image.network('https://picsum.photos/250?image=9'),
          ),
        ),
      ),
    );
  }
}
