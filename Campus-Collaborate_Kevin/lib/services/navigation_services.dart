import 'package:flutter/material.dart';

/// NavigationService class provides different functions as service in the context of navigation.
///
/// Services include:
/// * `pushScreen`
/// * `popAndPushScreen`
/// * `pushReplacementScreen`
/// * `removeAllAndPush`
/// * `pushDialog`
/// * `pop`
class NavigationService {
  /// Key for Navigator State.
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Pushes a Screen.
  ///
  /// **params**:
  /// * `routeName`: Name of the Route
  /// * `arguments`: Set of arguments
  ///
  /// **returns**:
  /// * `Future<dynamic>`: resolves if the Screen was succesfully pushed.
  Future<dynamic> pushScreen(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  /// This function pop the initial route and push the new route to the navigator.
  ///
  /// **params**:
  /// * `routeName`: Name of the Route
  /// * `arguments`: Set of arguments
  ///
  /// **returns**:
  /// * `Future<dynamic>`: resolves if the Screen was succesfully popAndPushed.
  Future<dynamic> popAndPushScreen(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.pop();
    return pushScreen(routeName, arguments: arguments);
  }

  /// This function push the route and replace the screen.
  ///
  /// **params**:
  /// * `routeName`: Name of the Route
  /// * `arguments`: Set of arguments
  ///
  /// **returns**:
  /// * `Future<dynamic>`: resolves if the Screen was succesfully pushedReplacementScreen.
  Future<dynamic> pushReplacementScreen(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// This function remove all the routes till the particular route and add new route.
  ///
  /// **params**:
  /// * `routeName`: Name of the Route
  /// * `tillRoute`: Route till we want to remove
  /// * `arguments`: Set of arguments
  ///
  /// **returns**:
  /// * `Future<dynamic>`: resolves if the Screen was succesfully removeAllAndPushed.
  Future<dynamic> removeAllAndPush(
    String routeName,
    String tillRoute, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(tillRoute),
      arguments: arguments,
    );
  }

  /// This function remove all the routes till the particular route and add new route.
  ///
  /// **params**:
  /// * `dialog`: Widget to show
  ///
  /// **returns**:
  ///   None
  void pushDialog(Widget dialog) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  /// This function pops the current state.
  ///
  /// **params**:
  ///   None
  ///
  /// **returns**:
  ///   None
  void pop() {
    return navigatorKey.currentState!.pop();
  }
}
