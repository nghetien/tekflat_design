part of '../data_table.dart';

class TekDataTableContentWidget<T> extends StatefulWidget {
  const TekDataTableContentWidget({
    Key? key,
    required this.tableColumns,
    this.fixedColumn = TekFixedColumn.none,
    required this.controller,
    this.topContent,
    this.bottomContent,
    this.showerMoreContentRowWidget,
    this.headerIntoRowWidget,
    this.verticalScrollState,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final List<DataTableColumn<T>> tableColumns;
  final TekFixedColumn fixedColumn;
  final TekDataTableController<T> controller;
  final TekOptionContentTable? topContent;
  final TekOptionContentTable? bottomContent;
  final TekShowerMoreContentIntoRowWidget<T>? showerMoreContentRowWidget;
  final TekHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekVerticalScrollState? verticalScrollState;
  final TekDataTableRowOption<T> rowOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;

  @override
  TekDataTableContentWidgetState<T> createState() => TekDataTableContentWidgetState<T>();
}

class TekDataTableContentWidgetState<T> extends State<TekDataTableContentWidget<T>> {
  int _expandedDataIndex = -1;
  List<T> _oldStateDataSource = [];
  bool isCompareDataSource = false;

  bool _isChangeDataSource() {
    if (!isCompareDataSource) {
      isCompareDataSource = true;
      return false;
    }
    if (_oldStateDataSource.isEmpty && widget.controller.dataSources.isEmpty) return false;
    if (_oldStateDataSource.length != widget.controller.dataSources.length) return true;
    for (int i = 0; i < _oldStateDataSource.length; i++) {
      if ((_oldStateDataSource[i] as dynamic).toJson()['id'] !=
          (widget.controller.dataSources[i] as dynamic).toJson()['id']) return true;
    }
    return false;
  }

  bool _isShowMore(int index) => _expandedDataIndex == index;

  void _handleChangeOldDataSource() {
    if (_isChangeDataSource()) {
      _oldStateDataSource = [...widget.controller.dataSources];
      _expandedDataIndex = -1;
    }
  }

  void _handleClickContent(int index, T rowData) {
    widget.rowOption.onPressRowItem?.call(rowData);
    if (widget.showerMoreContentRowWidget != null) {
      isCompareDataSource = false;
      _expandedDataIndex = _expandedDataIndex != index ? index : -1;
      widget.verticalScrollState?.calculateScroll();
      widget.verticalScrollState?.setState(() {});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _handleChangeOldDataSource();
    return Column(
      children: <Widget>[
        if (widget.topContent != null)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: TekBorders.thin, color: TekColors().greyOpacity04),
                right: BorderSide(width: 0, color: TekColors().greyOpacity04),
                left: BorderSide(width: 0, color: TekColors().greyOpacity04),
              ),
            ),
            child: widget.topContent!(widget.controller.initTableColumns,
                widget.controller.mapKeyToWidthOfEachColumnContent),
          ),
        _contents(),
        if (widget.bottomContent != null)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 0, color: TekColors().greyOpacity04),
                left: BorderSide(width: 0, color: TekColors().greyOpacity04),
              ),
            ),
            child: widget.bottomContent!(widget.controller.initTableColumns,
                widget.controller.mapKeyToWidthOfEachColumnContent),
          ),
      ],
    );
  }

  double? getHeightOfRow(int index) {
    if (widget.rowOption.heightOfRowItem != null) {
      return widget.rowOption.heightOfRowItem;
    }
    if (widget.fixedColumn != TekFixedColumn.none &&
        widget.controller.mapIndexToHeightOfEachRow.isNotEmpty &&
        widget.controller.mapIndexToHeightOfEachRow[index] != null) {
      return widget.controller.mapIndexToHeightOfEachRow[index]!;
    }
    return null;
  }

  Widget _contents() => ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.controller.dataSources.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          T rowData = widget.controller.dataSources[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 0, color: TekColors().greyOpacity01),
                left: BorderSide(width: 0, color: TekColors().greyOpacity01),
              ),
            ),
            child: TekDataTableRowWidget<T>(
              key: ObjectKey(rowData),
              tableColumns: widget.tableColumns,
              fixedColumn: widget.fixedColumn,
              height: getHeightOfRow(index),
              controller: widget.controller,
              indexRow: index,
              rowData: rowData,
              isShowMore: _isShowMore(index),
              onPressed: () => _handleClickContent(index, rowData),
              showerMoreContentRowWidget: widget.showerMoreContentRowWidget,
              headerIntoRowWidget: widget.headerIntoRowWidget,
              rowOption: widget.rowOption,
              checkBoxOption: widget.checkBoxOption,
            ),
          );
        },
      );
}
