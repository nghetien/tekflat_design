import 'package:flutter/material.dart';

enum TekContextPushTransitionType {
  basic,
  rightToLeft,
}

extension TekContextEx on BuildContext {

  ThemeData get theme => Theme.of(this);

  double get widthScreen => MediaQuery.of(this).size.width;

  double get heightScreen => MediaQuery.of(this).size.height;

  void popRootNavigator<T extends Object?>([T? result]) =>
      Navigator.of(this, rootNavigator: true).pop<T>(result);

  void popNavigator<T extends Object?>() => Navigator.pop<T>(this);

  void popUntilNavigator({
    required RoutePredicate predicate,
    bool rootNavigator = false,
  }) =>
      Navigator.of(
        this,
        rootNavigator: rootNavigator,
      ).popUntil(predicate);

  Future<T?> pushNavigator<T extends Object?>({
    required Widget page,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
    bool rootNavigator = false,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).push<T>(
        MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          allowSnapshotting: allowSnapshotting,
        ),
      );
}
