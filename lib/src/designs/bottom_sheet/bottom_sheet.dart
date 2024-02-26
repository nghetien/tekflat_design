library bottom_sheet;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tekflat_design/src/src.dart';

part 'bottom_sheet_selector.dart';
part 'tag_bottom_sheet.dart';

enum TekBottomSheetHeaderOption {
  option1,
  option2,
}

class TekBottomSheet {
  const TekBottomSheet._();

  static Future<T?> customizeBottomSheet<T>(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    bool isCustomize = false,
    TekBottomSheetHeaderOption headerOption = TekBottomSheetHeaderOption.option1,
    double? height,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    String? title,
    BorderRadius? borderRadius,
    TekTypographyType? titleType,
    FontWeight? titleFontWeight,
    bool? backBtnIsRight,
    bool? haveDivider,
    MainAxisSize? mainAxisSize,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height,
          child: isCustomize
              ? builder(context)
              : Column(
                  mainAxisSize: mainAxisSize ?? MainAxisSize.max,
                  children: [
                    if (headerOption == TekBottomSheetHeaderOption.option1)
                      TagBottomSheet2Widget(
                        title: title,
                        titleType: titleType,
                        titleFontWeight: titleFontWeight,
                        backBtnIsRight: backBtnIsRight ?? true,
                        haveDivider: haveDivider ?? true,
                      )
                    else
                      Column(
                        children: [
                          const TagBottomSheet1Widget(),
                          if (title != null && title.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: TekSpacings().mainSpacing),
                              child: TekTypography(
                                text: title,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    builder(context),
                  ],
                ),
        );
      },
      backgroundColor: backgroundColor ?? context.theme.bottomSheetTheme.backgroundColor,
      elevation: elevation ?? 0,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.vertical(
                  top: TekCorners().mainCornerRadius,
                ),
          ),
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
    );
  }

  static Future<T?> bottomSheetSelector<T>(
    BuildContext context, {
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    String? title,
    BorderRadius? borderRadius,
    // selector
    TekBottomSheetSelectorType? type,
    List<String>? initSelected,
    Future<List<TekBottomSheetSelectorModel<T>>?> Function()? initMenuChildren,
    Future<List<TekBottomSheetSelectorModel<T>>?> Function()? onLoadingMenuChildren,
    Future<List<TekBottomSheetSelectorModel<T>>?> Function()? onRefreshMenuChildren,
    Future<List<TekBottomSheetSelectorModel<T>>?> Function(
      String?,
      List<T>,
    )? onSearchMenuChildren,
    void Function(
      T,
      List<T>,
    )? onSelected,
    Widget Function(int, bool, TekBottomSheetSelectorModel<T>, TekBottomSheetSelectorType)?
        customItemBuilder,
    Widget? customHeader,
    Widget Function(BuildContext, int)? separatorBuilder,
    String? initSearchText,
    String? hintText,
    double? maxHeight,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (builderContext) => TekBottomSheetSelectorWidget<T>(
        title: title,
        type: type ?? TekBottomSheetSelectorType.single,
        initSelected: initSelected ?? [],
        initMenuChildren: initMenuChildren,
        onLoadingMenuChildren: onLoadingMenuChildren,
        onRefreshMenuChildren: onRefreshMenuChildren,
        onSearchMenuChildren: onSearchMenuChildren,
        onSelected: onSelected,
        customHeader: customHeader,
        customItemBuilder: customItemBuilder,
        separatorBuilder: separatorBuilder,
        initSearchText: initSearchText,
        borderRadius: borderRadius,
        hintText: hintText,
        constraints: constraints ??
            BoxConstraints(
              maxHeight: (maxHeight ?? MediaQuery.sizeOf(context).height * 0.55) -
                  (TekSpacings().mainSpacing * 2 + 28.scaleFontSize) -
                  (onSearchMenuChildren != null ? 70 : 0),
            ),
      ),
      backgroundColor: backgroundColor ?? context.theme.bottomSheetTheme.backgroundColor,
      elevation: elevation,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.vertical(
                  top: TekCorners().mainCornerRadius,
                ),
          ),
      clipBehavior: clipBehavior,
      constraints: constraints ??
          BoxConstraints(
            maxHeight: (maxHeight ?? MediaQuery.sizeOf(context).height * 0.55),
          ),
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
    );
  }
}
