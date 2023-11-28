import 'package:flutter/material.dart';
import 'package:tekflat_design/src/utils/utils.dart';

import '../styles/styles.dart';
import 'spaces.dart';

class TekSnackBar {
  const TekSnackBar._();

  static final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

  static EdgeInsets _defaultMargin = EdgeInsets.all(TekSpacings().mainSpacing);

  static EdgeInsets get defaultMargin => _defaultMargin;

  static void setDefaultMargin(EdgeInsets value) => _defaultMargin = value;

  static void showSnackBar({
    String? message,
    Widget? child,
    IconData? iconData,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    SnackBarBehavior? behavior,
    SnackBar? snackBar,
    double? elevation,
    bool? showCloseIcon,
    SnackBarAction? action,
    ShapeBorder? shape,
    Duration? duration,
    BuildContext? context,
  }) {
    if (snackBar != null) {
      if (context != null) {
        context.scaffoldMessengerState.showSnackBar(snackBar);
      } else {
        snackBarKey.currentState?.showSnackBar(snackBar);
      }
      return;
    }
    final defaultSnackBar = SnackBar(
      backgroundColor: backgroundColor ?? TekColors().primary,
      margin: margin ?? defaultMargin,
      padding: padding ?? EdgeInsets.all(TekSpacings().mainSpacing),
      duration: duration ?? const Duration(milliseconds: 2000),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (iconData != null) ...[
            Icon(
              iconData,
              color: TekColors().white,
            ),
            TekHSpace.p8,
          ],
          Expanded(
            child: child ??
                Text(
                  message ?? '',
                ),
          ),
        ],
      ),
      behavior: behavior ?? SnackBarBehavior.floating,
      elevation: elevation ?? 1,
      showCloseIcon: showCloseIcon,
      action: action,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: TekCorners().mainCornerBorder,
          ),
    );
    if (context != null) {
      context.scaffoldMessengerState.showSnackBar(defaultSnackBar);
    } else {
      snackBarKey.currentState?.showSnackBar(defaultSnackBar);
    }
  }

  static void showSuccessSnackBar({
    String? message,
    Widget? child,
    IconData? iconData,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    SnackBarBehavior? behavior,
    SnackBar? snackBar,
    double? elevation,
    bool? showCloseIcon,
    SnackBarAction? action,
    ShapeBorder? shape,
    Duration? duration,
    BuildContext? context,
  }) {
    showSnackBar(
      message: message,
      child: child,
      iconData: iconData ?? Icons.check_rounded,
      backgroundColor: backgroundColor ?? TekColors().green,
      margin: margin,
      padding: padding,
      behavior: behavior,
      snackBar: snackBar,
      elevation: elevation,
      showCloseIcon: showCloseIcon,
      action: action,
      shape: shape,
      duration: duration,
      context: context,
    );
  }

  static void showErrorSnackBar({
    String? message,
    Widget? child,
    IconData? iconData,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    SnackBarBehavior? behavior,
    SnackBar? snackBar,
    double? elevation,
    bool? showCloseIcon,
    SnackBarAction? action,
    ShapeBorder? shape,
    Duration? duration,
    BuildContext? context,
  }) {
    showSnackBar(
      message: message,
      child: child,
      iconData: iconData ?? Icons.error_rounded,
      backgroundColor: backgroundColor ?? TekColors().red,
      margin: margin,
      padding: padding,
      behavior: behavior,
      snackBar: snackBar,
      elevation: elevation,
      showCloseIcon: showCloseIcon,
      action: action,
      shape: shape,
      duration: duration,
      context: context,
    );
  }

  static void showWarningSnackBar({
    String? message,
    Widget? child,
    IconData? iconData,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    SnackBarBehavior? behavior,
    SnackBar? snackBar,
    double? elevation,
    bool? showCloseIcon,
    SnackBarAction? action,
    ShapeBorder? shape,
    Duration? duration,
    BuildContext? context,
  }) {
    showSnackBar(
      message: message,
      child: child,
      iconData: iconData ?? Icons.warning_rounded,
      backgroundColor: backgroundColor ?? TekColors().yellow,
      margin: margin,
      padding: padding,
      behavior: behavior,
      snackBar: snackBar,
      elevation: elevation,
      showCloseIcon: showCloseIcon,
      action: action,
      shape: shape,
      duration: duration,
      context: context,
    );
  }

  static void showInfoSnackBar({
    String? message,
    Widget? child,
    IconData? iconData,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    SnackBarBehavior? behavior,
    SnackBar? snackBar,
    double? elevation,
    bool? showCloseIcon,
    SnackBarAction? action,
    ShapeBorder? shape,
    Duration? duration,
    BuildContext? context,
  }) {
    showSnackBar(
      message: message,
      child: child,
      iconData: iconData ?? Icons.info_outlined,
      backgroundColor: backgroundColor ?? TekColors().blue,
      margin: margin,
      padding: padding,
      behavior: behavior,
      snackBar: snackBar,
      elevation: elevation,
      showCloseIcon: showCloseIcon,
      action: action,
      shape: shape,
      duration: duration,
      context: context,
    );
  }
}
