part of '../data_table.dart';

class TekDataTableHeaderWidget<T> extends StatefulWidget {
  const TekDataTableHeaderWidget({
    Key? key,
    required this.tableColumns,
    this.fixedColumn = TekFixedColumn.none,
    required this.controller,
    required this.headerOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final List<DataTableColumn<T>> tableColumns;
  final TekFixedColumn fixedColumn;
  final TekDataTableController<T> controller;
  final TekDataTableHeaderOption headerOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;

  static const double defaultHeightHeader = 40;

  @override
  State<TekDataTableHeaderWidget<T>> createState() => _TekDataTableHeaderWidgetState<T>();
}

class _TekDataTableHeaderWidgetState<T> extends State<TekDataTableHeaderWidget<T>> {
  MapEntry<String, TekDataTableSortType> _sortType = const MapEntry('', TekDataTableSortType.none);

  MapEntry<String, TekDataTableSortType> get sortType => _sortType;

  void _setSortType(MapEntry<String, TekDataTableSortType> value) =>
      setState(() => _sortType = value);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, __) => _generateHeaderItem(),
      );

  Radius _getRadiusRight() {
    if (widget.controller.haveFixedColumnsRight && widget.fixedColumn == TekFixedColumn.none) {
      return Radius.zero;
    }
    if (widget.fixedColumn == TekFixedColumn.left) {
      return Radius.zero;
    }
    return TekCorners().mainCornerRadius;
  }

  Radius _getRadiusLeft() {
    if (widget.controller.haveFixedColumnsLeft && widget.fixedColumn == TekFixedColumn.none) {
      return Radius.zero;
    }
    if (widget.fixedColumn == TekFixedColumn.right) {
      return Radius.zero;
    }
    return TekCorners().mainCornerRadius;
  }

  Widget _generateHeaderItem() {
    final List<Widget> headers = [];
    if (widget.tableColumns.isEmpty) {
      return Container(
        height:
            widget.headerOption.heightOfHeaderItem ?? TekDataTableHeaderWidget.defaultHeightHeader,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: TekColors().greyOpacity04,
              width: 0,
            ),
          ),
        ),
      );
    }
    for (int index = 0; index < widget.tableColumns.length; index++) {
      if (isShowInScreen(widget.tableColumns[index].showOnScreens)) {
        headers.add(
          TekDataTableHeaderItemWidget(
            key: ValueKey(widget.tableColumns[index].key),
            index: index,
            lengthOfColumn: widget.tableColumns.length,
            controller: widget.controller,
            column: widget.tableColumns[index],
            fixedColumn: widget.fixedColumn,
            headerOption: widget.headerOption,
            checkBoxOption: widget.checkBoxOption,
            sortType: sortType,
            onSelectSortType: _setSortType,
          ),
        );
      }
    }

    final borderRadius = widget.headerOption.decoration.borderRadius ??
        BorderRadius.only(
          topRight: _getRadiusRight(),
          topLeft: _getRadiusLeft(),
        );

    final color = widget.headerOption.decoration.backgroundColor ?? TekColors().primary;

    final border = widget.headerOption.decoration.border;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
        border: border,
      ),
      child: Row(
        children: headers,
      ),
    );
  }
}
