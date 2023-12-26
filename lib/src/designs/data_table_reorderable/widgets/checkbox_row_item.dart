part of '../data_table_reorderable.dart';

class TekCheckBoxRowItemReorderable<T> extends StatelessWidget {
  const TekCheckBoxRowItemReorderable({
    Key? key,
    required this.rowData,
    required this.controller,
    this.onSelectCheckBox,
  }) : super(key: key);

  final T rowData;
  final TekDataTableReorderableController<T> controller;
  final Function(Map<int, T>)? onSelectCheckBox;

  bool _getValueCheckBox() => controller.elementIsSelected(rowData);

  void _handleSelectBox(bool? value) {
    if (value == null) return;
    controller.selectElement(value, rowData);
    onSelectCheckBox?.call(controller.dataSelected);
  }

  @override
  Widget build(BuildContext context) => Checkbox(
        value: _getValueCheckBox(),
        onChanged: _handleSelectBox,
        hoverColor: Colors.transparent,
        activeColor: TekColors().primary,
        checkColor: TekColors().white,
        shape: const RoundedRectangleBorder(
          borderRadius: TekCorners.cornerBorder3,
        ),
        side: BorderSide(
          width: TekBorders.med,
          color: TekColors().primary,
        ),
      );
}
