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
}

class TekDialogs {
  const TekDialogs._();

  static Future<T?> defaultDialog<T>(
    BuildContext context, {
    double? width,
    double? height,
    bool barrierDismissible = true,
    Color? color,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    required Widget content,
  }) {
    final widthDefault = min<double>(context.widthScreen, 420.scaleSize);
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: width ?? widthDefault,
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
    Color? color,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    EdgeInsets? padding,
    required String title,
    VoidCallback? onPressedToTitle,
    String? customizeOkText,
    String? customizeCancelText,
    Future<bool> Function()? onOkPressed,
    VoidCallback? onCancelPressed,
    required Widget content,
    bool showFooter = true,
    Widget? customizeFooter,
  }) {
    final widthDefault = min<double>(context.widthScreen, 420.scaleSize);
    final heightDefault = min<double>(context.heightScreen, 500.scaleSize);
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: width ?? widthDefault,
          height: height ?? heightDefault,
          padding: padding ?? EdgeInsets.all(TekSpacings().mainPadding),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).cardColor,
            shape: shape,
            borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  onPressedToTitle == null
                      ? TekTypography(
                          text: title,
                          type: TekTypographyType.h5,
                          color: TekColors().primary,
                        )
                      : TekButtonGD(
                          type: TekButtonGDType.customize,
                          onPressed: () {
                            onPressedToTitle();
                          },
                          child: TekTypography(
                            text: title,
                            type: TekTypographyType.h5,
                            color: TekColors().primary,
                          ),
                        ),
                  TekVSpace.mainSpace,
                  const TekDivider(),
                  TekVSpace.p4,
                  Expanded(child: content),
                  if (showFooter)
                    Padding(
                      padding: EdgeInsets.only(top: TekSpacings().p4),
                      child: customizeFooter ??
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TekButton(
                                onPressed: () {
                                  onCancelPressed?.call();
                                  context.popNavigator();
                                },
                                size: TekButtonSize.large,
                                text: customizeCancelText ?? 'Cancel',
                                textColor: TekColors().primary,
                              ),
                              TekHSpace.mainSpace,
                              TekButton(
                                onPressed: () {
                                  onOkPressed?.call().then((value) {
                                    if (value) context.popNavigator();
                                  });
                                },
                                type: TekButtonType.primary,
                                size: TekButtonSize.large,
                                text: customizeOkText ?? 'Ok',
                              ),
                            ],
                          ),
                    ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: TekButtonGD(
                  type: TekButtonGDType.icon,
                  onPressed: () {
                    onCancelPressed?.call();
                    context.popNavigator();
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
    Future<bool> Function()? onClickButtonRight,
    VoidCallback? onClickButtonLeft,
    String? title,
    Widget? customTitle,
    String? content,
    String? buttonCancel,
    String? buttonText,
    Widget? customContent,
    double? width,
  }) =>
      defaultDialog<T>(
        context,
        width: width,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(TekSpacings().p12),
              decoration: BoxDecoration(
                color: type == TekDialogType.delete
                    ? TekColors.red
                    : type == TekDialogType.warning
                        ? TekColors.yellow
                        : TekColors.blueLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(TekCorners().mainCorners),
                  topRight: Radius.circular(TekCorners().mainCorners),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    type == TekDialogType.delete
                        ? Icons.delete
                        : type == TekDialogType.warning
                            ? Icons.warning
                            : Icons.info,
                    color: Colors.white,
                    size: TekIconSizes().s24,
                  ),
                  TekVSpace.p8,
                  customTitle ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: TekTextStyles.titleMedium.copyWith(color: TekColors.white),
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
                    style: TekTextStyles.body,
                  ),
                ),
            TekVSpace.p12,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TekSpacings().p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (type != TekDialogType.info)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: TekSpacings().p12),
                        child: TekButton(
                          onPressed: () {
                            if (onClickButtonLeft != null) {
                              onClickButtonLeft();
                            } else {
                              context.popNavigator();
                            }
                          },
                          type: TekButtonType.none,
                          size: TekButtonSize.large,
                          text: buttonCancel ?? 'Cancel',
                          textColor: TekColors.white,
                          background: TekColors.grey,
                        ),
                      ),
                    ),
                  Expanded(
                    child: TekButton(
                      size: TekButtonSize.large,
                      type: TekButtonType.primary,
                      onPressed: () {
                        onClickButtonRight?.call().then((value) {
                          if (value) context.popNavigator();
                        });
                      },
                      text: buttonText ?? 'OK',
                      background: type == TekDialogType.delete
                          ? TekColors.red
                          : type == TekDialogType.warning
                              ? TekColors.yellow
                              : TekColors.blueLight,
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
