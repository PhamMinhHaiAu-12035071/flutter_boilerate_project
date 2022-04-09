import 'package:flutter/material.dart';

typedef TransitionAnimationBuilder = Widget Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
  Widget,
);

///Each Screen must extend this class and provide its functionality
abstract class EPage extends Page<dynamic> {
  const EPage({
    required this.args,
    this.transitionDuration = 400,
    this.reverseTransitionDuration = 400,
    this.animationBuilder,
  });

  final Map<String, dynamic> args;
  final int transitionDuration, reverseTransitionDuration; //milliseconds

  ///Give each individual screen the option to define a special entry animation
  final TransitionAnimationBuilder? animationBuilder;

  Widget build(BuildContext context);

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
          animationBuilder?.call(
            context,
            animation,
            secondaryAnimation,
            child,
          ) ??
          _defaultAnimationBuilder(
            context,
            animation,
            secondaryAnimation,
            child,
          ),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> animation2,
      ) =>
          build(context),
    );
  }

  ///provide a default Transition for the app (you can delete it if you want,
  ///flutter already has one)
  Widget _defaultAnimationBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      textDirection: TextDirection.rtl,
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
