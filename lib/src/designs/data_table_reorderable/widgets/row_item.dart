part of '../data_table_reorderable.dart';

class TekDataTableReorderableRowItemWidget<T> extends StatelessWidget {
  const TekDataTableReorderableRowItemWidget({
    Key? key,
    required this.lengthOfColumn,
    required this.indexRow,
    required this.indexColumn,
    required this.rowData,
    required this.controller,
    required this.column,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final int lengthOfColumn;
  final int indexRow;
  final int indexColumn;
  final T rowData;
  final TekDataTableReorderableController<T> controller;
  final DataTableReorderableColumn<T> column;
  final TekDataTableReorderableRowOption<T> rowOption;
  final TekDataTableReorderableCheckBoxOption<T> checkBoxOption;

  @override
  Widget build(BuildContext context) {
    final double? widthOfRowItem = controller.mapKeyToWidthOfEachColumnContent[column.key];
    return SizedBox(
      width: widthOfRowItem,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 0.5,
              color: TekColors().greyOpacity04,
            ),
            left: BorderSide(
              width: 0.5,
              color: TekColors().greyOpacity04,
            ),
          ),
        ),
        child: _getWidgetRowItem(context, column, widthOfRowItem),
      ),
    );
  }

  Widget _getWidgetRowItem(
    BuildContext context,
    DataTableReorderableColumn<T> column,
    double? width,
  ) {
    if (column.key == TekDataTableReorderableAdditionColumn.checkbox.toString()) {
      return TekCheckBoxRowItemReorderable(
        rowData: rowData,
        controller: controller,
        onSelectCheckBox: checkBoxOption.onSelectCheckBox,
      );
    }
    if (column.key == TekDataTableReorderableAdditionColumn.numbered.toString()) {
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
        style: TekTextStyles().body,
      );

  Widget _numberedRowItem() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        ((controller.pagination.currentPage - 1) * controller.pagination.itemsPerPage +
                indexRow +
                1)
            .toString(),
        style: TekTextStyles().body.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}