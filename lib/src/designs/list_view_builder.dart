import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

import 'spaces.dart';

class TekListView<T> extends StatelessWidget {
  const TekListView({
    required this.items,
    this.numberOfItemsInRow = 1,
    this.spaceBetweenItemsInRow,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required this.itemBuilder,
    this.separatorBuilder,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  final List<T> items;
  final int numberOfItemsInRow;
  final double? spaceBetweenItemsInRow;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext, int, T) itemBuilder;
  final int? Function(Key)? findChildIndexCallback;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  int get itemCount => (items.length / numberOfItemsInRow).ceil();

  int get numberOfItemsInLastRow => items.length % numberOfItemsInRow;

  @override
  Widget build(BuildContext context) => ListView.separated(
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemBuilder: (context, index) {
          final int startIndex = index * numberOfItemsInRow;
          final int endIndex = min(startIndex + numberOfItemsInRow, items.length);
          final List<T> itemsInRow = items.sublist(startIndex, endIndex);
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              for (int i = 0; i < itemsInRow.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: i == 0 ? 0 : spaceBetweenItemsInRow ?? TekPaddings().mainPadding,
                    ),
                    child: itemBuilder(context, startIndex + i, itemsInRow[i]),
                  ),
                ),
              for (int i = endIndex; i < (startIndex + numberOfItemsInRow); i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: i == 0 ? 0 : spaceBetweenItemsInRow ?? TekPaddings().mainPadding,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                ),
            ],
          );
        },
        clipBehavior: clipBehavior,
        separatorBuilder: separatorBuilder ?? (_, __) => VSpace.mainSpace,
        findChildIndexCallback: findChildIndexCallback,
        itemCount: itemCount,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        dragStartBehavior: dragStartBehavior,
        restorationId: restorationId,
      );
}
