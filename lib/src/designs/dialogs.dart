import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';
import 'package:tekflat_design/src/utils/utils.dart';

import 'buttons/buttons.dart';
import 'divider.dart';
import 'spaces.dart';
import 'typography.dart';

enum TekDialogType {
  delete,
  warning,
  info,
  primary;

  Color get color {
    switch (this) {
      case TekDialogType.delete:
        return TekColors().red;
      case TekDialogType.warning:
        return TekColors().yellow;
      case TekDialogType.info:
        return TekColors().blue;
      case TekDialogType.primary:
        return TekColors().primary;
    }
  }

  IconData get icon {
    switch (this) {
      case TekDialogType.delete:
        return Icons.delete;
      case TekDialogType.warning:
        return Icons.warning;
      case TekDialogType.info:
        return Icons.info;
      case TekDialogType.primary:
        return Icons.info;
    }
  }
}

class TekDialogs {
  const TekDialogs._();

  static Future<T?> defaultDialog<T>(
    BuildContext context, {
    double? width,
    double? height,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    Color? color,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    required Widget content,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) => Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).cardColor,
            shape: shape,
            borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
          ),
          child: content,
        ),
      ),
    );
  }

  static Future<T?> customizeDialog<T>(
    BuildContext context, {
    double? width,
    double? height,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    Color? color,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    EdgeInsets? headerPadding,
    EdgeInsets? contentPadding,
    EdgeInsets? footerPadding,
    required String title,
    VoidCallback? onPressedToTitle,
    String? customizeOkText,
    String? customizeCancelText,
    Future<bool?> Function()? onOkPressed,
    VoidCallback? onCancelPressed,
    required Widget content,
    bool showFooter = true,
    Widget? customizeFooter,
    MainAxisSize? mainAxisSize,
    bool contentExpanded = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) => Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).cardColor,
            shape: shape,
            borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: mainAxisSize ?? MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: headerPadding ?? EdgeInsets.all(TekSpacings().mainSpacing).copyWith(
                      bottom: TekSpacings().p8,
                    ),
                    child: onPressedToTitle == null
                        ? TekTypography(
                            text: title,
                            color: TekColors().primary,
                            type: TekTypographyType.titleMedium,
                          )
                        : TekButtonGD(
                            onPressed: () {
                              onPressedToTitle();
                            },
                            child: TekTypography(
                              text: title,
                              color: TekColors().primary,
                              type: TekTypographyType.titleMedium,
                            ),
                          ),
                  ),
                  Padding(
                    padding: headerPadding ??
                        EdgeInsets.symmetric(horizontal: TekSpacings().mainSpacing),
                    child: const TekDivider(),
                  ),
                  TekVSpace.p4,
                  contentExpanded
                      ? Expanded(
                          child: Padding(
                            padding: contentPadding ??
                                EdgeInsets.all(TekSpacings().mainSpacing)
                                    .copyWith(top: TekSpacings().p4),
                            child: content,
                          ),
                        )
                      : Padding(
                          padding: contentPadding ??
                              EdgeInsets.all(TekSpacings().mainSpacing)
                                  .copyWith(top: TekSpacings().p4),
                          child: content,
                        ),
                  if (showFooter)
                    Padding(
                      padding: EdgeInsets.only(
                        top: TekSpacings().p4,
                        bottom: (footerPadding ?? EdgeInsets.all(TekSpacings().mainSpacing)).bottom,
                        right: (footerPadding ?? EdgeInsets.all(TekSpacings().mainSpacing)).right,
                        left: (footerPadding ?? EdgeInsets.all(TekSpacings().mainSpacing)).left,
                      ),
                      child: customizeFooter ??
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TekButton(
                                onPressed: () {
                                  onCancelPressed?.call();
                                  popNavigatorMultiPlatform(context);
                                },
                                size: TekButtonSize.medium,
                                text: customizeCancelText ?? 'Cancel',
                                textColor: TekColors().primary,
                                mainAxisSize: MainAxisSize.min,
                              ),
                              TekHSpace.mainSpace,
                              TekButton(
                                onPressed: () {
                                  onOkPressed?.call().then((value) {
                                    if (value == true) popNavigatorMultiPlatform(context);
                                  });
                                },
                                type: TekButtonType.primary,
                                size: TekButtonSize.medium,
                                text: customizeOkText ?? 'Ok',
                                mainAxisSize: MainAxisSize.min,
                              ),
                            ],
                          ),
                    ),
                ],
              ),
              Positioned(
                top: (headerPadding ?? EdgeInsets.all(TekSpacings().mainSpacing)).top,
                right: (headerPadding ?? EdgeInsets.all(TekSpacings().mainSpacing)).right,
                child: TekButtonGD(
                  onPressed: () {
                    onCancelPressed?.call();
                    popNavigatorMultiPlatform(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: TekColors().primary,
                    size: TekIconSizes().s24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<T?> optionDialog<T>(
    BuildContext context, {
    required TekDialogType type,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    Future<bool?> Function()? onClickButtonRight,
    Future<bool?> Function()? onClickButtonLeft,
    String? title,
    int? maxLinesTitle,
    Widget? customTitle,
    String? content,
    Color? mainColor,
    IconData? iconData,
    int? maxLinesContent,
    String? buttonCancel,
    String? buttonText,
    Widget? customContent,
    double? width,
  }) =>
      defaultDialog<T>(
        context,
        width: width ?? min<double>(context.widthScreen, 420),
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(TekSpacings().p12),
              decoration: BoxDecoration(
                color: mainColor ?? type.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(TekCorners().mainCorners),
                  topRight: Radius.circular(TekCorners().mainCorners),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    iconData ?? type.icon,
                    color: Colors.white,
                    size: TekIconSizes().s24,
                  ),
                  TekVSpace.p8,
                  customTitle ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: TekTextStyles().titleMedium.copyWith(color: TekColors().white),
                        maxLines: maxLinesTitle,
                      ),
                ],
              ),
            ),
            TekVSpace.p12,
            customContent ??
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: TekSpacings().p12),
                  child: Text(
                    content ?? '',
                    textAlign: TextAlign.center,
                    style: TekTextStyles().body,
                    maxLines: maxLinesContent,
                  ),
                ),
            TekVSpace.p12,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TekSpacings().p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (onClickButtonLeft != null)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: TekSpacings().p12),
                        child: TekButton(
                          onPressed: () {
                            onClickButtonLeft.call().then(
                              (value) {
                                if (value == true) popNavigatorMultiPlatform(context);
                              },
                            );
                          },
                          type: TekButtonType.outline,
                          size: TekButtonSize.medium,
                          text: buttonCancel ?? 'Cancel',
                          borderColor: type == TekDialogType.delete
                              ? TekColors().red
                              : type == TekDialogType.warning
                                  ? TekColors().yellow
                                  : TekColors().blue,
                          textColor: type == TekDialogType.delete
                              ? TekColors().red
                              : type == TekDialogType.warning
                                  ? TekColors().yellow
                                  : TekColors().blue,
                        ),
                      ),
                    ),
                  Expanded(
                    child: TekButton(
                      size: TekButtonSize.medium,
                      type: TekButtonType.primary,
                      onPressed: () {
                        onClickButtonRight?.call().then(
                          (value) {
                            if (value == true) popNavigatorMultiPlatform(context);
                          },
                        );
                      },
                      text: buttonText ?? 'OK',
                      background: mainColor ?? type.color,
                    ),
                  ),
                ],
              ),
            ),
            TekVSpace.p12,
          ],
        ),
      );
}
