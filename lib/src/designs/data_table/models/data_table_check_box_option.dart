part of '../data_table.dart';

class TekDataTableCheckBoxOption<T>{
  const TekDataTableCheckBoxOption({
    this.onSelectCheckBox,
  });

  final Function(Map<int, T>)? onSelectCheckBox;
}