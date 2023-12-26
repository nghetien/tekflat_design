part of '../data_table_reorderable.dart';

class TekDataTableReorderableHeaderOption {
  const TekDataTableReorderableHeaderOption({
    this.heightOfHeaderItem,
    this.alignment,
    this.padding,
    this.headerTextColor,
    this.decoration = const TekDataTableReorderableHeaderDecoration(),
  });

  final double? heightOfHeaderItem;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final TekDataTableReorderableHeaderDecoration decoration;
  final Color? headerTextColor;
}

/// Support setting decoration for header item
/// [backgroundColor] is background color of header item
/// [borderRadius] is border radius of header item
/// [border] is border of header item
///
/// If you want to set decoration for header item, you must set [TekDataTableHeaderOption] for [TekDataTableHeaderWidget]
/// and set [TekDataTableHeaderDecoration] for each [DataTableColumn]
class TekDataTableReorderableHeaderDecoration {
  const TekDataTableReorderableHeaderDecoration({
    this.backgroundColor,
    this.borderRadius,
    this.border,
  });

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
}
