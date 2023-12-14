part of '../data_table.dart';

class TekEventReloadFixedColumn {}

enum TekFixedColumn {
  none,
  left,
  right,
}

class TekFilterHeaderItem<T> {
  const TekFilterHeaderItem({
    this.offset,
    required this.heightPopup,
    required this.widthPopup,
    required this.child,
  });

  final Offset? offset;
  final double heightPopup;
  final double widthPopup;
  final TekCustomizeFilterWidget<T> child;
}

class DataTableColumn<T> {
  DataTableColumn({
    required this.key,
    this.name,
    this.width,
    this.maxWidth,
    this.minWidth,
    this.fixedColumn = TekFixedColumn.none,
    this.flex,
    this.customizeTitleWidget,
    this.showOnScreens,
    this.customizeItemWidget,
    this.isShowSort = false,
    this.sortDataVoid,
    this.isShowFilter = false,
    this.customizeFilter,
    this.defaultTextAlignment,
    this.defaultTextMaxLines,
    this.defaultTextColor,
  });

  final String key;
  final String? name;
  final double? width;
  final double? maxWidth;
  final double? minWidth;
  final TekFixedColumn fixedColumn;
  final int? flex;
  final TekCustomizeTitleWidget? customizeTitleWidget;
  final List<TekScreenDevice>? showOnScreens;
  final TekTableItemWidget<T>? customizeItemWidget;
  final bool isShowSort;
  final TekSortDataVoid<T>? sortDataVoid;
  final bool isShowFilter;
  final TekFilterHeaderItem<T>? customizeFilter;
  final AlignmentGeometry? defaultTextAlignment;
  final int? defaultTextMaxLines;
  final Color? defaultTextColor;
}
