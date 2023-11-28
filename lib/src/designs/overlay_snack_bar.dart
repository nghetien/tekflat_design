import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';
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
    IconData? iconData,
    Color? iconColor,
    double? iconSize,
    Color? backgroundColor,
    TextStyle? textStyle,
    int? maxLines,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    EdgeInsets? messagePadding,
    TextAlign? textAlign,
  }) {
    if (overlayState == null && context == null && _overlayState == null) return;

    Widget? content;
    switch (type) {
      case TekOverlaySnackBarType.info:
        content = _buildSnackBar(
          text: message,
          icon: icon,
          backgroundColor: backgroundColor ?? TekColors().blue,
          iconData: iconData ?? Icons.info_outline_rounded,
          iconColor: iconColor,
          textStyle: textStyle,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
          padding: messagePadding,
          maxLines: maxLines,
          textAlign: textAlign,
          iconSize: iconSize,
        );
        break;
      case TekOverlaySnackBarType.success:
        content = _buildSnackBar(
          text: message,
          icon: icon,
          backgroundColor: backgroundColor ?? TekColors().green,
          iconData: iconData ?? Icons.check_circle_outline_rounded,
          iconColor: iconColor,
          textStyle: textStyle,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
          padding: messagePadding,
          maxLines: maxLines,
          textAlign: textAlign,
          iconSize: iconSize,
        );
        break;
      case TekOverlaySnackBarType.warning:
        content = _buildSnackBar(
          text: message,
          icon: icon,
          backgroundColor: backgroundColor ?? TekColors().yellow,
          iconData: iconData ?? Icons.warning_amber_rounded,
          iconColor: iconColor,
          textStyle: textStyle,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
          padding: messagePadding,
          maxLines: maxLines,
          textAlign: textAlign,
          iconSize: iconSize,
        );
        break;
      case TekOverlaySnackBarType.error:
        content = _buildSnackBar(
          text: message,
          icon: icon,
          backgroundColor: backgroundColor ?? TekColors().red,
          iconData: iconData ?? Icons.error_outline_rounded,
          iconColor: iconColor,
          textStyle: textStyle,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
          padding: messagePadding,
          maxLines: maxLines,
          textAlign: textAlign,
          iconSize: iconSize,
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
      displayDuration: displayDuration ?? const Duration(milliseconds: 500),
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

  static Widget _buildSnackBar({
    EdgeInsets? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Widget? icon,
    IconData? iconData,
    Color? iconColor,
    double? iconSize,
    required String text,
    TextStyle? textStyle,
    int? maxLines,
    TextAlign? textAlign,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(TekSpacings().mainSpacing),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        boxShadow: boxShadow ?? TekShadows.lDown,
      ),
      child: Row(
        children: [
          icon ??
              Icon(
                iconData,
                color: iconColor ?? TekColors().white,
                size: iconSize ?? 20.scaleIconSize,
              ),
          TekHSpace.p8,
          Text(
            text,
            style: textStyle ??
                TekTextStyles().titleMedium.copyWith(
                      color: TekColors().white,
                    ),
            maxLines: maxLines,
            textAlign: textAlign,
          ),
        ],
      ),
    );
  }
}
