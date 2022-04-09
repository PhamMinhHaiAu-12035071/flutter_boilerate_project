// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

class CustomTransitionDelegate extends DefaultTransitionDelegate<dynamic> {
  const CustomTransitionDelegate() : super();

  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];
    // final bool showAnimation = locationToExitingPageRoute.isEmpty ||
    //     newPageRouteHistory.last.route.settings.name != '/list';
    // This method will handle the exiting route and its corresponding pageless
    // route at this location. It will also recursively check if there is any
    // other exiting routes above it and handle them accordingly.
    void handleExitingRoute({
      RouteTransitionRecord? location,
      required bool isLast,
    }) {
      final exitingPageRoute = locationToExitingPageRoute[location];
      if (exitingPageRoute == null) return;
      if (exitingPageRoute.isWaitingForExitingDecision) {
        final hasPagelessRoute =
            pageRouteToPagelessRoutes.containsKey(exitingPageRoute);
        final isLastExitingPageRoute =
            isLast && !locationToExitingPageRoute.containsKey(exitingPageRoute);
        if (isLastExitingPageRoute && !hasPagelessRoute) {
          exitingPageRoute.markForPop(exitingPageRoute.route.currentResult);
        } else {
          exitingPageRoute
              .markForComplete(exitingPageRoute.route.currentResult);
        }
        if (hasPagelessRoute) {
          final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute]!;
          for (final pagelessRoute in pagelessRoutes) {
            // It is possible that a pageless route that belongs to an exiting
            // page-based route does not require exiting decision. This can
            // happen if the page list is updated right after a Navigator.pop.
            if (pagelessRoute.isWaitingForExitingDecision) {
              if (isLastExitingPageRoute &&
                  pagelessRoute == pagelessRoutes.last) {
                pagelessRoute.markForPop(pagelessRoute.route.currentResult);
              } else {
                pagelessRoute
                    .markForComplete(pagelessRoute.route.currentResult);
              }
            }
          }
        }
      }
      results.add(exitingPageRoute);

      // It is possible there is another exiting route above this
      // exitingPageRoute.
      handleExitingRoute(location: exitingPageRoute, isLast: isLast);
    }

    // Handles exiting route in the beginning of list.
    handleExitingRoute(isLast: newPageRouteHistory.isEmpty);

    for (final pageRoute in newPageRouteHistory) {
      final isLastIteration = newPageRouteHistory.last == pageRoute;
      if (pageRoute.isWaitingForEnteringDecision) {
        if (!locationToExitingPageRoute.containsKey(pageRoute) &&
            isLastIteration) {
          pageRoute.markForPush();
        } else {
          pageRoute.markForAdd();
        }
      }
      results.add(pageRoute);
      handleExitingRoute(location: pageRoute, isLast: isLastIteration);
    }
    return results;
  }
}
