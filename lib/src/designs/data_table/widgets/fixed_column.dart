part of '../data_table.dart';

class TekDataTableFixedColumnWidget<T> extends StatelessWidget {
  const TekDataTableFixedColumnWidget({
    Key? key,
    required this.type,
    required this.controller,
    required this.headerOption,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final TekFixedColumn type;
  final TekDataTableController<T> controller;
  final TekDataTableHeaderOption headerOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;
  final TekDataTableRowOption<T> rowOption;

  Border _getBorder() {
    if (type == TekFixedColumn.left) {
      return Border(
        right: BorderSide(
          color: TekColors.greyOpacity04,
          width: TekBorders.thin,
        ),
      );
    } else {
      return Border(
        left: BorderSide(
          color: TekColors.greyOpacity04,
          width: TekBorders.thin,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: _getBorder(),
      ),
      child: Column(
        children: <Widget>[
          TekDataTableHeaderWidget<T>(
            tableColumns: type == TekFixedColumn.left
                ? controller.fixedColumnsLeft
                : controller.fixedColumnsRight,
            fixedColumn: type,
            controller: controller,
            headerOption: headerOption,
            checkBoxOption: checkBoxOption,
          ),
          DataTableFixedColumnContentWidget<T>(
            type: type,
            controller: controller,
            rowOption: rowOption,
            checkBoxOption: checkBoxOption,
          ),
        ],
      ),
    );
  }
}
