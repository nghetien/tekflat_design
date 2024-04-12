part of '../data_table.dart';

class TekDataTableHeaderOption {
  const TekDataTableHeaderOption({
    this.heightOfHeaderItem,
    this.splitColor,
    this.alignment,
    this.padding,
    this.headerTextColor,
    this.decoration = const TekDataTableHeaderDecoration(),
  });

  final double? heightOfHeaderItem;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final TekDataTableHeaderDecoration decoration;
  final Color? headerTextColor;
  final Color? splitColor;
}

/// Support setting decoration for header item
/// [backgroundColor] is background color of header item
/// [borderRadius] is border radius of header item
/// [border] is border of header item
///
/// If you want to set decoration for header item, you must set [TekDataTableHeaderOption] for [TekDataTableHeaderWidget]
/// and set [TekDataTableHeaderDecoration] for each [DataTableColumn]
class TekDataTableHeaderDecoration {
  const TekDataTableHeaderDecoration({
    this.backgroundColor,
    this.borderRadius,
    this.border,
  });

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
}
