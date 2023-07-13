import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TekRefresher extends StatelessWidget {
  const TekRefresher({
    required this.controller,
    this.child,
    this.onRefresh,
    this.onLoading,
    this.onTwoLevel,
    this.dragStartBehavior,
    this.primary,
    this.cacheExtent,
    this.semanticChildCount,
    this.reverse,
    this.physics,
    this.scrollDirection,
    this.scrollController,
    this.canLoadingText,
    this.failedText,
    this.idleText,
    this.loadingText,
    this.noDataText,
    Key? key,
  })  : builder = null,
        super(key: key);

  const TekRefresher.builder({
    Key? key,
    required this.controller,
    required this.builder,
    this.onRefresh,
    this.onLoading,
    this.onTwoLevel,
    this.canLoadingText,
    this.failedText,
    this.idleText,
    this.loadingText,
    this.noDataText,
  })  : child = null,
        scrollController = null,
        scrollDirection = null,
        physics = null,
        reverse = null,
        semanticChildCount = null,
        dragStartBehavior = null,
        cacheExtent = null,
        primary = null,
        super(key: key);

  final Widget? child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final OnTwoLevel? onTwoLevel;
  final RefreshController controller;
  final RefresherBuilder? builder;
  final Axis? scrollDirection;
  final bool? reverse;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior? dragStartBehavior;
  final String? canLoadingText;
  final String? failedText;
  final String? idleText;
  final String? loadingText;
  final String? noDataText;

  @override
  Widget build(BuildContext context) {
    return child != null
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              canLoadingText: canLoadingText ?? 'Release to load more',
              failedText: failedText ?? 'Load Failed',
              idleText: idleText ?? 'Pull up to load more',
              loadingText: loadingText ?? 'Loading...',
              noDataText: noDataText ?? 'No more data',
            ),
            controller: controller,
            onRefresh: onRefresh,
            onLoading: onLoading,
            onTwoLevel: onTwoLevel,
            primary: primary,
            physics: physics,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            cacheExtent: cacheExtent,
            reverse: reverse,
            scrollDirection: scrollDirection,
            scrollController: scrollController,
            key: key,
            child: child,
          )
        : SmartRefresher.builder(
            controller: controller,
            builder: builder,
            onRefresh: onRefresh,
            onLoading: onLoading,
            onTwoLevel: onTwoLevel,
            enablePullDown: true,
            enablePullUp: true,
            key: key,
          );
  }
}
