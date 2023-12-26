part of '../data_table_reorderable.dart';

class TekCheckBoxColumnReorderable<T> extends StatelessWidget {
  const TekCheckBoxColumnReorderable({
    Key? key,
    required this.controller,
    this.onSelectCheckBox,
  }) : super(key: key);

  final TekDataTableReorderableController<T> controller;
  final Function(Map<int, T>)? onSelectCheckBox;

  void _handleSelectAll(bool? value) {
    if (value == null) return;
    controller.selectAll(value);
    onSelectCheckBox?.call(controller.dataSelected);
  }

  bool _getValueCheckBoxAll() {
    if (controller.dataSources.isEmpty) return false;
    return controller.dataSources.every((element) => controller.elementIsSelected(element));
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _getValueCheckBoxAll(),
      onChanged: _handleSelectAll,
      activeColor: TekColors().white,
      checkColor: TekColors().primary,
      shape: const RoundedRectangleBorder(
        borderRadius: TekCorners.cornerBorder3,
      ),
      side: BorderSide(
        width: TekBorders.med,
        color: TekColors().white,
      ),
    );
  }
}
