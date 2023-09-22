part of '../data_table.dart';

class TekDataTableRowItemWidget<T> extends StatelessWidget {
  const TekDataTableRowItemWidget({
    Key? key,
    this.fixedColumn = TekFixedColumn.none,
    required this.lengthOfColumn,
    required this.indexRow,
    required this.indexColumn,
    required this.rowData,
    required this.controller,
    required this.column,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final TekFixedColumn fixedColumn;
  final int lengthOfColumn;
  final int indexRow;
  final int indexColumn;
  final T rowData;
  final TekDataTableController<T> controller;
  final DataTableColumn<T> column;
  final TekDataTableRowOption<T> rowOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;

  @override
  Widget build(BuildContext context) {
    final double? widthOfRowItem = fixedColumn != TekFixedColumn.none
        ? column.width
        : controller.mapKeyToWidthOfEachColumnContent[column.key];
    return SizedBox(
      width: widthOfRowItem,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: indexColumn < lengthOfColumn - 1
                ? BorderSide(
                    color: TekColors().greyOpacity04,
                    width: TekBorders.thin,
                  )
                : BorderSide.none,
          ),
        ),
        child: _getWidgetRowItem(context, column, widthOfRowItem),
      ),
    );
  }

  Widget _getWidgetRowItem(
    BuildContext context,
    DataTableColumn<T> column,
    double? width,
  ) {
    if (column.key == TekDataTableAdditionColumn.checkbox.toString()) {
      return TekCheckBoxRowItem(
        rowData: rowData,
        controller: controller,
        onSelectCheckBox: checkBoxOption.onSelectCheckBox,
      );
    }
    if (column.key == TekDataTableAdditionColumn.numbered.toString()) {
      return _numberedRowItem();
    }
    if (column.customizeItemWidget != null) {
      return Padding(
        padding: rowOption.paddingOfRowItem ?? EdgeInsets.all(TekSpacings().p4),
        child: column.customizeItemWidget!(
          context,
          (rowData as dynamic).toJson()[column.key],
          rowData,
          column.key,
          column.name,
          width,
          column.showOnScreens,
        ),
      );
    }
    return Container(
      padding: rowOption.paddingOfRowItem ?? EdgeInsets.all(TekSpacings().p4),
      alignment: column.defaultTextAlignment ?? Alignment.center,
      child: _defaultRowItem(
        value: (rowData as dynamic).toJson()[column.key],
        rowData: rowData,
        maxLines: column.defaultTextMaxLines,
      ),
    );
  }

  Widget _defaultRowItem({
    required dynamic value,
    required T rowData,
    int? maxLines,
  }) =>
      Text(
        value != null ? value.toString() : '',
        style: TekTextStyles.body,
      );

  Widget _numberedRowItem() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        ((controller.pagination.currentPage - 1) * controller.pagination.itemsPerPage +
                indexRow +
                1)
            .toString(),
        style: TekTextStyles.body.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}