part of '../data_table_reorderable.dart';

class TekDataTableReorderableContentWidget<T> extends StatefulWidget {
  const TekDataTableReorderableContentWidget({
    Key? key,
    required this.tableColumns,
    required this.controller,
    this.topContent,
    this.bottomContent,
    this.showerMoreContentRowWidget,
    this.headerIntoRowWidget,
    this.verticalScrollState,
    required this.rowOption,
    required this.checkBoxOption,
    required this.onReorder,
    this.onNoReorder,
    this.onReorderStarted,
  }) : super(key: key);

  final List<DataTableReorderableColumn<T>> tableColumns;
  final TekDataTableReorderableController<T> controller;
  final TekReorderableOptionContentTable? topContent;
  final TekReorderableOptionContentTable? bottomContent;
  final TekReorderableShowerMoreContentIntoRowWidget<T>? showerMoreContentRowWidget;
  final TekReorderableHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekVerticalScrollState? verticalScrollState;
  final TekDataTableReorderableRowOption<T> rowOption;
  final TekDataTableReorderableCheckBoxOption<T> checkBoxOption;
  final TekReorderableOnReorderVoid<T> onReorder;
  final TekReorderableOnNoReorderVoid<T>? onNoReorder;
  final TekReorderableOnReorderStartedVoid<T>? onReorderStarted;

  @override
  State<TekDataTableReorderableContentWidget<T>> createState() =>
      _TekDataTableReorderableContentWidgetState<T>();
}

class _TekDataTableReorderableContentWidgetState<T>
    extends State<TekDataTableReorderableContentWidget<T>> {
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
                right: BorderSide(width: 0, color: TekColors().greyOpacity04),
                left: BorderSide(width: 0, color: TekColors().greyOpacity04),
              ),
            ),
            child: widget.topContent!(widget.controller.initTableColumns,
                widget.controller.mapKeyToWidthOfEachColumnContent),
          ),
        TekDataTableReorderableContentBuilder(
          controller: widget.controller,
          tableColumns: widget.tableColumns,
          rowOption: widget.rowOption,
          onShowMore: _isShowMore,
          onClickContent: (index, rowData) => () => _handleClickContent(index, rowData),
          showerMoreContentRowWidget: widget.showerMoreContentRowWidget,
          headerIntoRowWidget: widget.headerIntoRowWidget,
          checkBoxOption: widget.checkBoxOption,
          onReorder: widget.onReorder,
          onNoReorder: widget.onNoReorder,
          onReorderStarted: widget.onReorderStarted,
        ),
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
}
