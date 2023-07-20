part of '../data_table.dart';

class TekDataTableRowWidget<T> extends StatelessWidget {
  const TekDataTableRowWidget({
    Key? key,
    required this.tableColumns,
    this.fixedColumn = TekFixedColumn.none,
    required this.controller,
    required this.indexRow,
    required this.rowData,
    this.isShowMore = false,
    this.showerMoreContentRowWidget,
    this.headerIntoRowWidget,
    required this.onPressed,
    this.height,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final List<DataTableColumn<T>> tableColumns;
  final TekFixedColumn fixedColumn;
  final TekDataTableController<T> controller;
  final int indexRow;
  final T rowData;
  final bool isShowMore;
  final VoidCallback onPressed;
  final TekShowerMoreContentIntoRowWidget<T>? showerMoreContentRowWidget;
  final TekHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final double? height;
  final TekDataTableRowOption<T> rowOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;

  @override
  Widget build(BuildContext context) {
    final Widget? headerRowWidget =
        headerIntoRowWidget?.call(rowData, controller.mapKeyToWidthOfEachColumnContent);
    if (fixedColumn != TekFixedColumn.none) {
      return Column(
        children: <Widget>[
          if (headerRowWidget != null)
            _wrapHeaderIntoRowWidget(
              child: headerRowWidget,
            ),
          _wrapContent(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _generateRowItem(context),
              ),
            ),
          ),
          if (isShowMore)
            _wrapShowMore(
              child: showerMoreContentRowWidget!(rowData),
            )
        ],
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: rowOption.bordered
            ? Border(
                left: BorderSide(
                  width: 0,
                  color: TekColors().greyOpacity04,
                ),
                right: BorderSide(
                  width: 0,
                  color: TekColors().greyOpacity04,
                ),
              )
            : null,
      ),
      child: TekMeasureSize(
        onChange: (Size size) {
          final bool canEdit = controller.canEditHeightOfEachRow(
            indexRow,
            size.height,
          );
          if (canEdit) controller.reloadHeightFixedContent();
        },
        child: Column(
          children: <Widget>[
            if (headerRowWidget != null)
              _wrapHeaderIntoRowWidget(
                child: headerRowWidget,
              ),
            _wrapContent(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _generateRowItem(context),
                ),
              ),
            ),
            if (isShowMore)
              _wrapShowMore(
                child: showerMoreContentRowWidget!(rowData),
              )
          ],
        ),
      ),
    );
  }

  List<Widget> _generateRowItem(BuildContext context) {
    final List<Widget> rowItems = [];
    for (int indexColumn = 0; indexColumn < tableColumns.length; indexColumn++) {
      if (isShowInScreen(tableColumns[indexColumn].showOnScreens)) {
        rowItems.add(
          TekDataTableRowItemWidget(
            fixedColumn: fixedColumn,
            indexRow: indexRow,
            indexColumn: indexColumn,
            lengthOfColumn: tableColumns.length,
            rowData: rowData,
            controller: controller,
            column: tableColumns[indexColumn],
            rowOption: rowOption,
            checkBoxOption: checkBoxOption,
          ),
        );
      }
    }
    return rowItems;
  }

  Widget _wrapContent({required Widget child}) => Container(
        height: height,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: TekBorders.thin,
              color: TekColors().greyOpacity04,
            ),
          ),
        ),
        child: fixedColumn != TekFixedColumn.none ||
                controller.haveFixedColumnsLeft ||
                controller.haveFixedColumnsRight
            ? child
            : InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                splashColor: Colors.transparent,
                onTap: onPressed,
                mouseCursor: rowOption.onPressRowItem != null
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: child,
              ),
      );

  Widget _wrapShowMore({required Widget child}) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: TekBorders.thin, color: TekColors().greyOpacity04),
            right: BorderSide(width: TekBorders.thin, color: TekColors().greyOpacity04),
            left: BorderSide(width: TekBorders.thin, color: TekColors().greyOpacity04),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(TekSpacings().p4),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: TekBorders.thick, color: TekColors().primary),
              left: BorderSide(width: TekBorders.thick, color: TekColors().primary),
            ),
          ),
          child: child,
        ),
      );

  Widget _wrapHeaderIntoRowWidget({required Widget child}) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: TekBorders.thin, color: TekColors().greyOpacity04),
          ),
        ),
        child: child,
      );
}
