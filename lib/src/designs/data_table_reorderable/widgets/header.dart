part of '../data_table_reorderable.dart';

class TekDataTableReorderableHeaderWidget<T> extends StatefulWidget {
  const TekDataTableReorderableHeaderWidget({
    Key? key,
    required this.tableColumns,
    required this.controller,
    required this.headerOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final List<DataTableReorderableColumn<T>> tableColumns;
  final TekDataTableReorderableController<T> controller;
  final TekDataTableReorderableHeaderOption headerOption;
  final TekDataTableReorderableCheckBoxOption<T> checkBoxOption;

  static const double defaultHeightHeader = 40;

  @override
  State<TekDataTableReorderableHeaderWidget<T>> createState() => _TekDataTableReorderableHeaderWidgetState<T>();
}

class _TekDataTableReorderableHeaderWidgetState<T> extends State<TekDataTableReorderableHeaderWidget<T>> {
  MapEntry<String, TekDataTableReorderableSortType> _sortType = const MapEntry('', TekDataTableReorderableSortType.none);

  MapEntry<String, TekDataTableReorderableSortType> get sortType => _sortType;

  void _setSortType(MapEntry<String, TekDataTableReorderableSortType> value) =>
      setState(() => _sortType = value);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, __) => _generateHeaderItem(),
      );

  Radius _getRadiusRight() {
    return TekCorners().mainCornerRadius;
  }

  Radius _getRadiusLeft() {
    return TekCorners().mainCornerRadius;
  }

  Widget _generateHeaderItem() {
    final List<Widget> headers = [];
    if (widget.tableColumns.isEmpty) {
      return Container(
        height:
            widget.headerOption.heightOfHeaderItem ?? TekDataTableReorderableHeaderWidget.defaultHeightHeader,
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
      if (isShowInScreenReorderable(widget.tableColumns[index].showOnScreens)) {
        headers.add(
          TekDataTableReorderableHeaderItemWidget(
            key: ValueKey(widget.tableColumns[index].key),
            index: index,
            lengthOfColumn: widget.tableColumns.length,
            controller: widget.controller,
            column: widget.tableColumns[index],
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
