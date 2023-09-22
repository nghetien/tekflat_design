import 'package:flutter/material.dart';

enum TekContextPushTransitionType {
  basic,
  rightToLeft,
}

extension TekContextEx on BuildContext {

  ThemeData get theme => Theme.of(this);

  double get widthScreen => MediaQuery.sizeOf(this).width;

  double get heightScreen => MediaQuery.sizeOf(this).height;

  void popRootNavigator<T extends Object?>([T? result]) =>
      Navigator.of(this, rootNavigator: true).pop<T>(result);

  void popNavigator<T extends Object?>([T? result]) => Navigator.pop<T>(this, result);

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

  Future<T?> replaceNavigator<T extends Object?>({
    required Widget page,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
    bool rootNavigator = false,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pushReplacement<T, T>(
        MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          allowSnapshotting: allowSnapshotting,
        ),
      );

  Future pushUntilNavigator<T extends Object?>({
    required Widget page,
    required RoutePredicate predicate,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
    bool rootNavigator = false,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pushAndRemoveUntil<T>(
        MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          allowSnapshotting: allowSnapshotting,
        ),
        predicate,
      );
}
