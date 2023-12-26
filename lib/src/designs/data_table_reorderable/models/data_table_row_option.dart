part of '../data_table_reorderable.dart';

class TekDataTableReorderableRowOption<T> {
  const TekDataTableReorderableRowOption({
    this.paddingOfRowItem,
    this.heightOfRowItem,
    this.onPressRowItem,
  });

  final EdgeInsets? paddingOfRowItem;
  final double? heightOfRowItem;
  final Function(T)? onPressRowItem;
}
