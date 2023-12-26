part of '../data_table_reorderable.dart';

class TekDataTableReorderableCheckBoxOption<T>{
  const TekDataTableReorderableCheckBoxOption({
    this.onSelectCheckBox,
  });

  final Function(Map<int, T>)? onSelectCheckBox;
}