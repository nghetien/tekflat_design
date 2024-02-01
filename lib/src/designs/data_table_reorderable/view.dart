part of 'data_table_reorderable.dart';

class TekDataTableReorderable<T> extends StatefulWidget {
  const TekDataTableReorderable({
    Key? key,
    required this.controller,
    required this.tableColumns,
    this.additionColumns = const [],
    this.topContent,
    this.bottomContent,
    this.showerMoreContentIntoRowWidget,
    this.headerIntoRowWidget,
    this.handleChangeData,
    this.optionUI,
    this.headerOption,
    this.rowOption,
    this.columnOption,
    this.paginationOption,
    this.checkBoxOption,
    this.scrollOption,
    required this.onReorder,
    this.onNoReorder,
    this.onReorderStarted,
  }) : super(key: key);

  final TekDataTableReorderableController<T> controller;
  final List<DataTableReorderableColumn<T>> tableColumns;
  final List<TekDataTableReorderableAdditionColumn> additionColumns;
  final TekReorderableOptionContentTable? topContent;
  final TekReorderableOptionContentTable? bottomContent;
  final TekReorderableShowerMoreContentIntoRowWidget<T>? showerMoreContentIntoRowWidget;
  final TekReorderableHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekReorderableAsyncDataSource<T>? handleChangeData;
  final TekDataTableReorderableOptionUI? optionUI;
  final TekDataTableReorderableHeaderOption? headerOption;
  final TekDataTableReorderableRowOption<T>? rowOption;
  final TekDataTableReorderableColumnOption? columnOption;
  final TekDataTableReorderablePaginationOption? paginationOption;
  final TekDataTableReorderableCheckBoxOption<T>? checkBoxOption;
  final TekDataTableReorderableScrollOption? scrollOption;
  final TekReorderableOnReorderVoid<T> onReorder;
  final TekReorderableOnNoReorderVoid<T>? onNoReorder;
  final TekReorderableOnReorderStartedVoid<T>? onReorderStarted;

  @override
  State<TekDataTableReorderable<T>> createState() => _TekDataTableReorderableState<T>();
}

class _TekDataTableReorderableState<T> extends State<TekDataTableReorderable<T>> {
  late TekDataTableReorderableController<T> _webDataTableController;
  late final TekDataTableReorderableOptionUI _optionUI;
  late final TekDataTableReorderableHeaderOption _headerOption;
  late final TekDataTableReorderableRowOption<T> _rowOption;
  late final TekDataTableReorderableColumnOption _columnOption;
  late final TekDataTableReorderablePaginationOption _paginationOption;
  late final TekDataTableReorderableCheckBoxOption<T> _checkBoxOption;
  late final TekDataTableReorderableScrollOption _scrollOption;

  void _handleSetState() {
    if (mounted) setState(() {});
  }

  void _handleInitState({
    bool needToInitPagination = false,
  }) {
    assert(
    widget.tableColumns.map((e) => e.key).toSet().length == widget.tableColumns.length,
    'Mỗi key của từng cột phải khác nhau',
    );
    if (needToInitPagination) {
      _webDataTableController.initPagination(
        currentPage: _paginationOption.currentPage,
        itemsPerPage: _paginationOption.itemsPerPage,
        listItemsPerPage: _paginationOption.listItemsPerPage,
        numberNextPage: _paginationOption.numberNextPage,
      );
    }
    _webDataTableController.initDataTable(
      initTableColumns: widget.tableColumns,
      additionColumns: widget.additionColumns,
    );
    assert(
    _webDataTableController.dataSources.every(
          (element) {
        dynamic elementId = (element as dynamic).toJson()['id'];
        return elementId != null &&
            TekDynamicExtension.ableParseToInt(elementId) &&
            TekDynamicExtension.isPositiveNumber(elementId);
      },
    ),
    'Tất cả các đối tượng dataSources phải có thuộc tính id dạng int và là số dương',
    );
  }

  @override
  void initState() {
    _webDataTableController = widget.controller;
    _optionUI = widget.optionUI ?? const TekDataTableReorderableOptionUI();
    _headerOption = widget.headerOption ?? const TekDataTableReorderableHeaderOption();
    _rowOption = widget.rowOption ?? const TekDataTableReorderableRowOption();
    _columnOption = widget.columnOption ?? const TekDataTableReorderableColumnOption();
    _paginationOption = widget.paginationOption ?? const TekDataTableReorderablePaginationOption();
    _checkBoxOption = widget.checkBoxOption ?? const TekDataTableReorderableCheckBoxOption();
    _scrollOption = widget.scrollOption ?? const TekDataTableReorderableScrollOption();
    _handleInitState(needToInitPagination: true);
    _webDataTableController.addListener(_handleSetState);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TekDataTableReorderable<T> oldWidget) {
    if (widget.controller != oldWidget.controller) {
      _webDataTableController.removeListener(_handleSetState);
      _webDataTableController = widget.controller;
      _handleInitState(needToInitPagination: true);
      _webDataTableController.addListener(_handleSetState);
    }
    if ((widget.tableColumns != oldWidget.tableColumns) ||
        (widget.tableColumns.length != oldWidget.tableColumns.length)) {
      _handleInitState();
      setState(() {});
    }
    if (widget.additionColumns != oldWidget.additionColumns) {
      _webDataTableController.additionColumns = widget.additionColumns;
      _handleInitState();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _webDataTableController.removeListener(_handleSetState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: TekCorners.cornerBorder8,
          color: context.theme.colorScheme.background,
        ),
        child: _genContentTable(),
      ),
      if (_webDataTableController.isLoading)
        const Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: TekDataTableReorderableLoadingWidget(),
        ),
    ],
  );

  Widget _genContentTable() {
    if (_optionUI.fixTableInAScreen) {
      return TekFixedDataTableReorderableWidget<T>(
        controller: _webDataTableController,
        topContent: widget.topContent,
        bottomContent: widget.bottomContent,
        showerMoreContentIntoRowWidget: widget.showerMoreContentIntoRowWidget,
        handleChangeData: widget.handleChangeData,
        headerOption: _headerOption,
        rowOption: _rowOption,
        columnOption: _columnOption,
        paginationOption: _paginationOption,
        checkBoxOption: _checkBoxOption,
        headerIntoRowWidget: widget.headerIntoRowWidget,
        scrollOption: _scrollOption,
        onReorder: widget.onReorder,
        onReorderStarted: widget.onReorderStarted,
        onNoReorder: widget.onNoReorder,
      );
    }
    return TekDefaultDataTableReorderableWidget<T>(
      controller: _webDataTableController,
      topContent: widget.topContent,
      bottomContent: widget.bottomContent,
      showerMoreContentIntoRowWidget: widget.showerMoreContentIntoRowWidget,
      handleChangeData: widget.handleChangeData,
      headerOption: _headerOption,
      rowOption: _rowOption,
      columnOption: _columnOption,
      paginationOption: _paginationOption,
      checkBoxOption: _checkBoxOption,
      headerIntoRowWidget: widget.headerIntoRowWidget,
      scrollOption: _scrollOption,
      onReorder: widget.onReorder,
      onReorderStarted: widget.onReorderStarted,
      onNoReorder: widget.onNoReorder,
    );
  }
}