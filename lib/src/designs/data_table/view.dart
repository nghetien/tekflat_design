part of 'data_table.dart';

class TekDataTable<T> extends StatefulWidget {
  const TekDataTable({
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
  }) : super(key: key);

  final TekDataTableController<T> controller;
  final List<DataTableColumn<T>> tableColumns;
  final List<TekDataTableAdditionColumn> additionColumns;
  final TekOptionContentTable? topContent;
  final TekOptionContentTable? bottomContent;
  final TekShowerMoreContentIntoRowWidget<T>? showerMoreContentIntoRowWidget;
  final TekHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekAsyncDataSource<T>? handleChangeData;
  final TekDataTableOptionUI? optionUI;
  final TekDataTableHeaderOption? headerOption;
  final TekDataTableRowOption<T>? rowOption;
  final TekDataTableColumnOption? columnOption;
  final TekDataTablePaginationOption? paginationOption;
  final TekDataTableCheckBoxOption<T>? checkBoxOption;

  @override
  TekDataTableState<T> createState() => TekDataTableState<T>();
}

class TekDataTableState<T> extends State<TekDataTable<T>> {
  late TekDataTableController<T> _webDataTableController;
  late final TekDataTableOptionUI _optionUI;
  late final TekDataTableHeaderOption _headerOption;
  late final TekDataTableRowOption<T> _rowOption;
  late final TekDataTableColumnOption _columnOption;
  late final TekDataTablePaginationOption _paginationOption;
  late final TekDataTableCheckBoxOption<T> _checkBoxOption;

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
    assert(
      _webDataTableController.initTableColumns.every(
        (element) =>
            element.fixedColumn == TekFixedColumn.none ||
            (element.fixedColumn != TekFixedColumn.none &&
                widget.topContent == null &&
                widget.bottomContent == null &&
                widget.showerMoreContentIntoRowWidget == null &&
                widget.headerIntoRowWidget == null),
      ),
      'Nếu DataTable có FixedColumn thí sẽ không được thêm top hoặc bottom hoặc showMoreContent content',
    );
    assert(
      _webDataTableController.initTableColumns.every(
        (element) =>
            element.fixedColumn == TekFixedColumn.none ||
            (element.fixedColumn != TekFixedColumn.none && element.width != null),
      ),
      'Tất cả các cột nếu set FixedColumn left hoặc right đều phải có width',
    );
  }

  @override
  void initState() {
    _webDataTableController = widget.controller;
    _optionUI = widget.optionUI ?? const TekDataTableOptionUI();
    _headerOption = widget.headerOption ?? const TekDataTableHeaderOption();
    _rowOption = widget.rowOption ?? const TekDataTableRowOption();
    _columnOption = widget.columnOption ?? const TekDataTableColumnOption();
    _paginationOption = widget.paginationOption ?? const TekDataTablePaginationOption();
    _checkBoxOption = widget.checkBoxOption ?? const TekDataTableCheckBoxOption();
    _handleInitState(needToInitPagination: true);
    _webDataTableController.addListener(_handleSetState);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TekDataTable<T> oldWidget) {
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
              child: TekDataTableLoadingWidget(),
            ),
        ],
      );

  Widget _genContentTable() {
    if (_optionUI.fixTableInAScreen) {
      return TekFixedDataTableWidget<T>(
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
      );
    }
    return TekDefaultDataTableWidget<T>(
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
    );
  }
}