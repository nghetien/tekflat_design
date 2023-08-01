library bottom_sheet;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tekflat_design/src/src.dart';

part 'bottom_sheet_selector.dart';

class TekBottomSheet {
  const TekBottomSheet._();

  static Future<T?> customizeBottomSheet<T>(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
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
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(TekSpacings().mainSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: TekTypography(
                      text: title ?? '',
                      type: TekTypographyType.level5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TekButtonInkwell(
                    onPressed: () {},
                    child: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const TekDivider(),
            builder(context),
          ],
        );
      },
      backgroundColor: backgroundColor,
      elevation: elevation ?? 0,
      shape: shape,
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
    // selector
    TekBottomSheetSelectorType? type,
    List<String>? initSelected,
    Future<List<TekBottomSheetSelectorModel<T>>> Function()? initMenuChildren,
    Future<List<TekBottomSheetSelectorModel<T>>> Function()? onLoadingMenuChildren,
    Future<List<TekBottomSheetSelectorModel<T>>> Function()? onRefreshMenuChildren,
    Future<List<TekBottomSheetSelectorModel<T>>> Function(
      String?,
      List<T>,
    )? onSearchMenuChildren,
    void Function(
      T,
      List<T>,
    )? onSelected,
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
        initSearchText: initSearchText,
        hintText: hintText,
        constraints: constraints ??
            BoxConstraints(
              maxHeight: (maxHeight ?? MediaQuery.of(context).size.height * 0.55) -
                  (TekSpacings().mainSpacing * 2 + 28.scaleFontSize) -
                  (onSearchMenuChildren != null ? 70 : 0),
            ),
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints ??
          BoxConstraints(
            maxHeight: (maxHeight ?? MediaQuery.of(context).size.height * 0.55),
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
