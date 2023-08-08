part of 'data_table.dart';

class TekDataTableController<T> extends ChangeNotifier {
  late final DataTableState<T> _state;
  List<DataTableColumn<T>> initTableColumns = [];
  List<TekDataTableAdditionColumn> additionColumns = [];
  final reloadFixedColumnStreamController = StreamController<TekEventReloadFixedColumn>.broadcast();

  TekDataTableController({
    List<T>? dataSources,
    int? totalRecords,
    Map<int, T>? dataSelected,
  }) : _state = DataTableState<T>(
          dataSources: dataSources,
          totalRecords: totalRecords,
          dataSelected: dataSelected,
        );

  void initDataTableState({
    List<T>? dataSources,
    int? totalRecords,
    Map<int, T>? dataSelected,
    int? itemsPerPage,
    List<int>? listItemsPerPage,
    int? numberNextPage,
    int? currentPage,
  }) {
    _state.dataSources = dataSources ?? _state.dataSources;
    _state.totalRecords = totalRecords ?? _state.totalRecords;
    _state.dataSelected = dataSelected ?? _state.dataSelected;
    initPagination(
      listItemsPerPage: listItemsPerPage,
      itemsPerPage: itemsPerPage,
      numberNextPage: numberNextPage,
      currentPage: currentPage,
    );
    notifyListeners();
  }

  void clearDataTable() {
    this.initTableColumns = [];
    this.additionColumns = [];
    _state.fixedColumnsLeft = [];
    _state.fixedColumnsRight = [];
    _state.tableColumnsContent = [];
  }

  void initDataTable({
    List<DataTableColumn<T>> initTableColumns = const [],
    List<TekDataTableAdditionColumn> additionColumns = const [],
  }) {
    clearDataTable();
    this.initTableColumns = List.from(initTableColumns);
    this.additionColumns = additionColumns;
    final List<DataTableColumn<T>> tableColumnsContent = [];
    final List<DataTableColumn<T>> fixedColumnsRight = [];
    final List<DataTableColumn<T>> fixedColumnsLeft = [];
    for (var element in this.initTableColumns) {
      if (element.fixedColumn == TekFixedColumn.left) {
        fixedColumnsLeft.add(element);
      } else if (element.fixedColumn == TekFixedColumn.right) {
        fixedColumnsRight.add(element);
      } else {
        tableColumnsContent.add(element);
      }
    }
    if (this.additionColumns.isNotEmpty) {
      for (var element in this.additionColumns) {
        this.initTableColumns.insert(
              0,
              DataTableColumn<T>(
                name: '',
                key: element.toString(),
                width: getWithAdditionColumn(element),
              ),
            );
        if (fixedColumnsLeft.isNotEmpty) {
          fixedColumnsLeft.insert(
            0,
            DataTableColumn<T>(
              name: '',
              key: element.toString(),
              width: getWithAdditionColumn(element),
            ),
          );
        } else {
          tableColumnsContent.insert(
            0,
            DataTableColumn<T>(
              name: '',
              key: element.toString(),
              width: getWithAdditionColumn(element),
            ),
          );
        }
      }
    }
    _state.tableColumnsContent = tableColumnsContent;
    _state.fixedColumnsRight = fixedColumnsRight;
    _state.fixedColumnsLeft = fixedColumnsLeft;
  }

  List<T> get dataSources => _state.dataSources;

  int get totalRecords => _state.totalRecords;

  TekDataTablePagination get pagination => _state.pagination;

  bool get haveFixedColumnsLeft => _state.fixedColumnsLeft.isNotEmpty;

  bool get haveFixedColumnsRight => _state.fixedColumnsRight.isNotEmpty;

  Map<int, double?> get mapIndexToHeightOfEachRow => _state.mapIndexToHeightOfEachRow;

  Map<String, double> get mapKeyToWidthOfEachColumnContent =>
      _state.mapKeyToWidthOfEachColumnContent;

  List<DataTableColumn<T>> get tableColumnsContent => _state.tableColumnsContent;

  List<DataTableColumn<T>> get fixedColumnsLeft => _state.fixedColumnsLeft;

  List<DataTableColumn<T>> get fixedColumnsRight => _state.fixedColumnsRight;

  double? get widthOfColumnsContent => _state.widthOfColumnsContent;

  double? get widthOfLeftColumns {
    final double? widget = getWidthOfColumn(fixedColumnsLeft);
    if (widget == null) return null;
    return widget + TekBorders.thin; // + 1 TekBorders.thin
  }

  double? get widthOfRightColumns {
    final double? widget = getWidthOfColumn(fixedColumnsRight);
    if (widget == null) return null;
    return widget + TekBorders.thin; // + 1 TekBorders.thin
  }

  bool get isWidthColumnLargeThanWidthTable => _state.isWidthColumnLargeThanWidthTable;

  bool get isLoading => _state.isLoading;

  Map<int, T> get dataSelected => _state.dataSelected;

  void setDataSources(List<T> dataSources) {
    _state.dataSources = dataSources;
    notifyListeners();
  }

  void reloadDataTable() => notifyListeners();

  void resetFirstPage() {
    _state.pagination.currentPage = 1;
    calculatePagination();
    notifyListeners();
  }

  void setTotalRecords(int totalRecords) {
    _state.totalRecords = totalRecords;
    calculatePagination();
    notifyListeners();
  }

  void sort([int Function(T a, T b)? compare]) {
    _state.dataSources.sort(compare);
    notifyListeners();
  }

  void initPagination({
    List<int>? listItemsPerPage,
    int? itemsPerPage,
    int? numberNextPage,
    int? currentPage,
  }) {
    final List<int> newListItemsPerPage =
        listItemsPerPage ?? TekDataTablePagination.defaultListItemsPerPage;
    _state.pagination = TekDataTablePagination(
      pageNumber: calculatePageNumber(newListItemsPerPage[0]),
      itemsPerPage: itemsPerPage ?? newListItemsPerPage[0],
      listItemsPerPage: newListItemsPerPage,
      numberNextPage: numberNextPage,
      currentPage: currentPage,
    );
    calculatePagination();
  }

  void calculatePagination(){
    _state.pagination.pageNumber = calculatePageNumber(_state.pagination.itemsPerPage);
    _state.pagination.calculatePagination();
  }

  void setCurrentPage(int currentPage) {
    _state.pagination.currentPage = currentPage;
    calculatePagination();
    notifyListeners();
  }

  void setItemsPerPage(int itemsPerPage) => _state.pagination.itemsPerPage = itemsPerPage;

  void setPageNumber(int pageNumber) => _state.pagination.pageNumber = pageNumber;

  int calculatePageNumber(int itemPerPage) => (_state.totalRecords / itemPerPage).ceil();

  void selectAll(bool withValue) {
    if (withValue) {
      _state.dataSelected = {};
      for (var element in dataSources) {
        _state.dataSelected[(element as dynamic).toJson()['id']] = element;
      }
    } else {
      _state.dataSelected = {};
    }
    notifyListeners();
  }

  bool elementIsSelected(T data) =>
      _state.dataSelected.containsKey((data as dynamic).toJson()['id']);

  void selectElement(bool value, T data) {
    if (value) {
      _state.dataSelected[(data as dynamic).toJson()['id']] = data;
    } else {
      _state.dataSelected.remove((data as dynamic).toJson()['id']);
    }
    notifyListeners();
  }

  void clearSelected() {
    _state.dataSelected = {};
    notifyListeners();
  }

  bool canEditHeightOfEachRow(int index, double? value) {
    if (value != _state.mapIndexToHeightOfEachRow[index]) {
      _state.mapIndexToHeightOfEachRow[index] = value;
      return true;
    }
    return false;
  }

  double? getWidthOfColumn(List<DataTableColumn<T>> columns) {
    double widthOfColumns = 0;
    for (final column in columns) {
      if (column.width == null && column.minWidth == null) {
        return null;
      }
      if (isShowInScreen(column.showOnScreens)) {
        widthOfColumns += column.width ?? column.minWidth!;
      }
    }
    return widthOfColumns;
  }

  void reloadHeightFixedContent() =>
      reloadFixedColumnStreamController.add(TekEventReloadFixedColumn());

  void setLoading(bool value) {
    _state.isLoading = value;
    notifyListeners();
  }

  void toggleLoading() {
    _state.isLoading = !_state.isLoading;
    notifyListeners();
  }

  void calculateWidthOfAllColumnsContent() {
    double cloneWidthOfAllColumns = _state.widthOfColumnsContent!;
    final List<DataTableColumn<T>> tableColumnsContentWithWidth = [];
    final List<DataTableColumn<T>> tableColumnsContentWithFlex = [];
    int sumOfAllFlex = 0;
    for (var element in this.tableColumnsContent) {
      if (isShowInScreen(element.showOnScreens)) {
        if (element.width != null) {
          tableColumnsContentWithWidth.add(element);
        } else {
          sumOfAllFlex += element.flex ?? 1;
          tableColumnsContentWithFlex.add(element);
        }
      } else {
        _state.mapKeyToWidthOfEachColumnContent[element.key] = 0;
      }
    }
    for (var element in tableColumnsContentWithWidth) {
      _state.mapKeyToWidthOfEachColumnContent[element.key] = element.width!;
      cloneWidthOfAllColumns -= element.width!;
    }

    if (isWidthColumnLargeThanWidthTable) {
      for (var element in tableColumnsContentWithFlex) {
        if (cloneWidthOfAllColumns <= 0) {
          assert(
            false,
            'Tổng độ rộng của các cột được set minWidth và maxWidth phải nhỏ hơn độ dài của màn hình (nếu trong danh sách cột có cột set mặc định hoặc flex)',
          );
          return;
        }
        _state.mapKeyToWidthOfEachColumnContent[element.key] = element.minWidth!;
        cloneWidthOfAllColumns -= element.minWidth!;
      }
      return;
    }

    _calculateWidthOfEachColumn(
      tableColumns: tableColumnsContentWithFlex,
      widthOfAllColumns: cloneWidthOfAllColumns,
      sumOfAllFlex: sumOfAllFlex,
    );
  }

  void _calculateWidthOfEachColumn({
    required List<DataTableColumn<T>> tableColumns,
    required double widthOfAllColumns,
    required int sumOfAllFlex,
  }) {
    if (tableColumns.isEmpty) return;
    final List<DataTableColumn<T>> columnsRemove = [];
    double widthAllColumns = widthOfAllColumns;
    int flexAllColumns = sumOfAllFlex;
    double aFlex = widthAllColumns / flexAllColumns;
    for (int index = 0; index < tableColumns.length; index++) {
      if (widthOfAllColumns <= 0) {
        assert(
          false,
          'Tổng độ rộng của các cột được set minWidth và maxWidth phải nhỏ hơn độ dài của màn hình (nếu trong danh sách cột có cột set mặc định hoặc flex)',
        );
        return;
      }
      final DataTableColumn<T> element = tableColumns[index];
      final double flexOfColumn = (element.flex ?? 1) * aFlex;
      if (element.maxWidth != null && element.minWidth != null) {
        final double width = flexOfColumn.clamp(element.minWidth!, element.maxWidth!);
        if (flexOfColumn != width) {
          _state.mapKeyToWidthOfEachColumnContent[element.key] = width;
          widthAllColumns -= width;
          flexAllColumns -= element.flex ?? 1;
          columnsRemove.add(element);
        } else {
          if (columnsRemove.isEmpty) {
            _state.mapKeyToWidthOfEachColumnContent[element.key] = width;
          }
        }
      } else if (element.minWidth != null && element.maxWidth == null) {
        final double width = max(flexOfColumn, element.minWidth!);
        if (flexOfColumn != width) {
          _state.mapKeyToWidthOfEachColumnContent[element.key] = width;
          widthAllColumns -= width;
          flexAllColumns -= element.flex ?? 1;
          columnsRemove.add(element);
        } else {
          if (columnsRemove.isEmpty) {
            _state.mapKeyToWidthOfEachColumnContent[element.key] = width;
          }
        }
      } else if (element.maxWidth != null && element.minWidth == null) {
        final double width = min(flexOfColumn, element.maxWidth!);
        if (flexOfColumn != width) {
          _state.mapKeyToWidthOfEachColumnContent[element.key] = width;
          widthAllColumns -= width;
          flexAllColumns -= element.flex ?? 1;
          columnsRemove.add(element);
        } else {
          if (columnsRemove.isEmpty) {
            _state.mapKeyToWidthOfEachColumnContent[element.key] = width;
          }
        }
      } else {
        if (columnsRemove.isEmpty) {
          _state.mapKeyToWidthOfEachColumnContent[element.key] = flexOfColumn;
        }
      }
    }
    if (columnsRemove.isNotEmpty) {
      _calculateWidthOfEachColumn(
        tableColumns: tableColumns.where((element) => !columnsRemove.contains(element)).toList(),
        widthOfAllColumns: widthAllColumns,
        sumOfAllFlex: flexAllColumns,
      );
    }
  }

  void setWidthOfColumnsContent(double value) {
    final double? widthOfAllContent = getWidthOfColumn(tableColumnsContent);
    _state.isWidthColumnLargeThanWidthTable = false;
    if (widthOfAllContent == null) {
      _state.widthOfColumnsContent = value;
    } else if (widthOfAllContent <= value) {
      _state.widthOfColumnsContent = value;
    } else {
      _state.isWidthColumnLargeThanWidthTable = true;
      _state.widthOfColumnsContent = widthOfAllContent;
    }
  }
}
