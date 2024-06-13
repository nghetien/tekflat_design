import 'package:flutter/material.dart';

enum TekContextPushTransitionType {
  basic,
  rightToLeft,
}

extension TekContextEx on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get widthScreen => MediaQuery.sizeOf(this).width;

  double get heightScreen => MediaQuery.sizeOf(this).height;

  EdgeInsets get paddingScreen => MediaQuery.paddingOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  TextScaler get textScaleFactor => MediaQuery.textScalerOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  EdgeInsets get systemGestureInsets => MediaQuery.systemGestureInsetsOf(this);

  ScaffoldMessengerState get scaffoldMessengerState => ScaffoldMessenger.of(this);

  TextTheme get textTheme => theme.textTheme;

  OverlayState get overlayState => Overlay.of(this);

  void popRootNavigator<T extends Object?>([T? result]) {
    if (Navigator.of(this, rootNavigator: true).canPop()) {
      Navigator.of(this, rootNavigator: true).pop<T>(result);
    }
  }

  void popNavigator<T extends Object?>([T? result]) {
    if (Navigator.canPop(this)) {
      Navigator.pop<T>(this, result);
    }
  }

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

  Future<bool> canPopNavigator() => Navigator.of(this).maybePop();
}
