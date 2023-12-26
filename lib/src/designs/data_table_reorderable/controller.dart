part of 'data_table_reorderable.dart';

class TekDataTableReorderableController<T> extends ChangeNotifier {
  late final DataTableReorderableState<T> _state;
  List<DataTableReorderableColumn<T>> initTableColumns = [];
  List<TekDataTableReorderableAdditionColumn> additionColumns = [];

  TekDataTableReorderableController({
    List<T>? dataSources,
    int? totalRecords,
    Map<int, T>? dataSelected,
  }) : _state = DataTableReorderableState<T>(
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
    _state.tableColumnsContent = [];
  }

  void initDataTable({
    List<DataTableReorderableColumn<T>> initTableColumns = const [],
    List<TekDataTableReorderableAdditionColumn> additionColumns = const [],
  }) {
    clearDataTable();
    this.initTableColumns = List.from(initTableColumns);
    this.additionColumns = additionColumns;
    final List<DataTableReorderableColumn<T>> tableColumnsContent = [];
    for (var element in this.initTableColumns) {
      tableColumnsContent.add(element);
    }
    if (this.additionColumns.isNotEmpty) {
      for (var element in this.additionColumns) {
        this.initTableColumns.insert(
          0,
          DataTableReorderableColumn<T>(
            name: '',
            key: element.toString(),
            width: getWithAdditionColumnReorderable(element),
          ),
        );
        tableColumnsContent.insert(
          0,
          DataTableReorderableColumn<T>(
            name: '',
            key: element.toString(),
            width: getWithAdditionColumnReorderable(element),
          ),
        );
      }
    }
    _state.tableColumnsContent = tableColumnsContent;
  }

  List<T> get dataSources => _state.dataSources;

  int get totalRecords => _state.totalRecords;

  TekDataTableReorderablePagination get pagination => _state.pagination;

  Map<int, double?> get mapIndexToHeightOfEachRow => _state.mapIndexToHeightOfEachRow;

  Map<String, double> get mapKeyToWidthOfEachColumnContent =>
      _state.mapKeyToWidthOfEachColumnContent;

  List<DataTableReorderableColumn<T>> get tableColumnsContent => _state.tableColumnsContent;

  double? get widthOfColumnsContent => _state.widthOfColumnsContent;

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
        listItemsPerPage ?? TekDataTableReorderablePagination.defaultListItemsPerPage;
    _state.pagination = TekDataTableReorderablePagination(
      pageNumber: calculatePageNumber(newListItemsPerPage[0]),
      itemsPerPage: itemsPerPage ?? newListItemsPerPage[0],
      listItemsPerPage: newListItemsPerPage,
      numberNextPage: numberNextPage,
      currentPage: currentPage,
    );
    calculatePagination();
  }

  void reorderRow(int oldIndex, int newIndex) {
    List<T> cloneDataSources = List.from(dataSources);
    final temp = cloneDataSources[oldIndex];
    cloneDataSources[oldIndex] = cloneDataSources[newIndex];
    cloneDataSources[newIndex] = temp;
    setDataSources(cloneDataSources);
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

  double? getWidthOfColumn(List<DataTableReorderableColumn<T>> columns) {
    double widthOfColumns = 0;
    for (final column in columns) {
      if (column.width == null && column.minWidth == null) {
        return null;
      }
      if (isShowInScreenReorderable(column.showOnScreens)) {
        widthOfColumns += column.width ?? column.minWidth!;
      }
    }
    return widthOfColumns;
  }

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
    final List<DataTableReorderableColumn<T>> tableColumnsContentWithWidth = [];
    final List<DataTableReorderableColumn<T>> tableColumnsContentWithFlex = [];
    int sumOfAllFlex = 0;
    for (var element in this.tableColumnsContent) {
      if (isShowInScreenReorderable(element.showOnScreens)) {
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
    required List<DataTableReorderableColumn<T>> tableColumns,
    required double widthOfAllColumns,
    required int sumOfAllFlex,
  }) {
    if (tableColumns.isEmpty) return;
    final List<DataTableReorderableColumn<T>> columnsRemove = [];
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
      final DataTableReorderableColumn<T> element = tableColumns[index];
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
