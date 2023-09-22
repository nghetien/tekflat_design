part of '../data_table.dart';

class TekFixedColumnForFixedTable<T> extends StatelessWidget {
  const TekFixedColumnForFixedTable({
    Key? key,
    required this.type,
    required this.controller,
    required this.verticalFixedColumnScrollController,
    required this.headerOption,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final TekFixedColumn type;
  final TekDataTableController<T> controller;
  final ScrollController verticalFixedColumnScrollController;
  final TekDataTableHeaderOption headerOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;
  final TekDataTableRowOption<T> rowOption;

  Border _getBorder() {
    if (type == TekFixedColumn.left) {
      return Border(
        right: BorderSide(
          color: TekColors().greyOpacity04,
          width: TekBorders.thin,
        ),
      );
    } else {
      return Border(
        left: BorderSide(
          color: TekColors().greyOpacity04,
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
          TekDataTableHeaderWidget(
            tableColumns: type == TekFixedColumn.left
                ? controller.fixedColumnsLeft
                : controller.fixedColumnsRight,
            fixedColumn: type,
            controller: controller,
            checkBoxOption: checkBoxOption,
            headerOption: headerOption,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                controller: verticalFixedColumnScrollController,
                scrollDirection: Axis.vertical,
                child: DataTableFixedColumnContentWidget<T>(
                  type: type,
                  controller: controller,
                  checkBoxOption: checkBoxOption,
                  rowOption: rowOption,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
