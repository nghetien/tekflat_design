import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum TekOverlaySnackBarType {
  info,
  success,
  warning,
  error,
  custom,
}

class TekOverlaySnackBar {
  static OverlayState? _overlayState;

  static void setOverlayState(OverlayState? overlayState) => _overlayState = overlayState;

  static void showOverlaySnackBar({
    BuildContext? context,
    OverlayState? overlayState,
    TekOverlaySnackBarType type = TekOverlaySnackBarType.custom,
    Widget? child,
    Duration? animationDuration,
    Duration? reverseAnimationDuration,
    Duration? displayDuration,
    VoidCallback? onTap,
    bool persistent = false,
    ControllerCallback? onAnimationControllerInit,
    EdgeInsets? padding,
    Curve? curve,
    Curve? reverseCurve,
    DismissType? dismissType,
    SnackBarPosition? snackBarPosition,
    List<DismissDirection>? dismissDirection,
    bool safeAreaValuesTop = true,
    bool safeAreaValuesBottom = true,
    EdgeInsets? safeAreaValuesMinimum,

    // SnackBar
    String message = '',
    Widget? icon,
    Color? backgroundColor,
    TextStyle? textStyle,
    int? maxLines,
    int? iconRotationAngle,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    double? iconPositionTop,
    double? iconPositionLeft,
    EdgeInsetsGeometry? messagePadding,
    double? textScaleFactor,
    TextAlign? textAlign,
  }) {
    if (overlayState == null && context == null && _overlayState == null) return;

    Widget? content;
    switch (type) {
      case TekOverlaySnackBarType.info:
        final CustomSnackBar sample = CustomSnackBar.info(message: message);
        content = CustomSnackBar.info(
          message: message,
          icon: icon ?? sample.icon,
          textStyle: textStyle ?? sample.textStyle,
          maxLines: maxLines ?? sample.maxLines,
          iconRotationAngle: iconRotationAngle ?? sample.iconRotationAngle,
          iconPositionTop: iconPositionTop ?? sample.iconPositionTop,
          iconPositionLeft: iconPositionLeft ?? sample.iconPositionLeft,
          backgroundColor: backgroundColor ?? sample.backgroundColor,
          boxShadow: boxShadow ?? sample.boxShadow,
          borderRadius: borderRadius ?? sample.borderRadius,
          messagePadding: messagePadding ?? sample.messagePadding,
          textScaleFactor: textScaleFactor ?? sample.textScaleFactor,
          textAlign: textAlign ?? sample.textAlign,
        );
        break;
      case TekOverlaySnackBarType.success:
        final CustomSnackBar sample = CustomSnackBar.success(message: message);
        content = CustomSnackBar.success(
          message: message,
          icon: icon ?? sample.icon,
          textStyle: textStyle ?? sample.textStyle,
          maxLines: maxLines ?? sample.maxLines,
          iconRotationAngle: iconRotationAngle ?? sample.iconRotationAngle,
          iconPositionTop: iconPositionTop ?? sample.iconPositionTop,
          iconPositionLeft: iconPositionLeft ?? sample.iconPositionLeft,
          backgroundColor: backgroundColor ?? sample.backgroundColor,
          boxShadow: boxShadow ?? sample.boxShadow,
          borderRadius: borderRadius ?? sample.borderRadius,
          messagePadding: messagePadding ?? sample.messagePadding,
          textScaleFactor: textScaleFactor ?? sample.textScaleFactor,
          textAlign: textAlign ?? sample.textAlign,
        );
        break;
      case TekOverlaySnackBarType.warning:
        final CustomSnackBar sample = CustomSnackBar.error(message: message);
        content = CustomSnackBar.error(
          message: message,
          icon: icon ??
              const Icon(
                Icons.warning_amber_rounded,
                color: Color(0x15000000),
                size: 120,
              ),
          textStyle: textStyle ?? sample.textStyle,
          maxLines: maxLines ?? sample.maxLines,
          iconRotationAngle: iconRotationAngle ?? sample.iconRotationAngle,
          iconPositionTop: iconPositionTop ?? sample.iconPositionTop,
          iconPositionLeft: iconPositionLeft ?? sample.iconPositionLeft,
          backgroundColor: backgroundColor ?? TekColors().yellow,
          boxShadow: boxShadow ?? sample.boxShadow,
          borderRadius: borderRadius ?? sample.borderRadius,
          messagePadding: messagePadding ?? sample.messagePadding,
          textScaleFactor: textScaleFactor ?? sample.textScaleFactor,
          textAlign: textAlign ?? sample.textAlign,
        );
        break;
      case TekOverlaySnackBarType.error:
        final CustomSnackBar sample = CustomSnackBar.error(message: message);
        content = CustomSnackBar.error(
          message: message,
          icon: icon ?? sample.icon,
          textStyle: textStyle ?? sample.textStyle,
          maxLines: maxLines ?? sample.maxLines,
          iconRotationAngle: iconRotationAngle ?? sample.iconRotationAngle,
          iconPositionTop: iconPositionTop ?? sample.iconPositionTop,
          iconPositionLeft: iconPositionLeft ?? sample.iconPositionLeft,
          backgroundColor: backgroundColor ?? sample.backgroundColor,
          boxShadow: boxShadow ?? sample.boxShadow,
          borderRadius: borderRadius ?? sample.borderRadius,
          messagePadding: messagePadding ?? sample.messagePadding,
          textScaleFactor: textScaleFactor ?? sample.textScaleFactor,
          textAlign: textAlign ?? sample.textAlign,
        );
        break;
      case TekOverlaySnackBarType.custom:
        content = child ?? const SizedBox.shrink();
        break;
    }

    showTopSnackBar(
      context?.overlayState ?? overlayState ?? _overlayState!,
      content,
      animationDuration: animationDuration ?? const Duration(milliseconds: 1200),
      reverseAnimationDuration: reverseAnimationDuration ?? const Duration(milliseconds: 550),
      displayDuration: displayDuration ?? const Duration(milliseconds: 3000),
      onTap: onTap,
      persistent: persistent,
      onAnimationControllerInit: onAnimationControllerInit,
      padding: padding ?? EdgeInsets.all(TekSpacings().mainSpacing),
      curve: curve ?? Curves.elasticOut,
      reverseCurve: reverseCurve ?? Curves.linearToEaseOut,
      dismissType: dismissType ?? DismissType.onTap,
      safeAreaValues: SafeAreaValues(
        bottom: safeAreaValuesBottom,
        top: safeAreaValuesTop,
        minimum: safeAreaValuesMinimum ?? EdgeInsets.zero,
      ),
      snackBarPosition: snackBarPosition ?? SnackBarPosition.bottom,
      dismissDirection: dismissDirection ?? const [DismissDirection.up],
    );
  }
}
