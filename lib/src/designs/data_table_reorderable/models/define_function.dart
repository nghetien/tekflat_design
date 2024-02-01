part of '../data_table_reorderable.dart';

enum TekDataTableReorderableSortType { asc, desc, none }

typedef TekReorderableShowerMoreContentIntoRowWidget<T> = Widget Function(T rowData);

typedef TekReorderableHeaderIntoRowWidget<T> = Widget? Function(T rowData, Map<String, double> widthOfColumns);

typedef TekReorderableOptionContentTable = Widget Function(
    List<DataTableReorderableColumn> columns, Map<String, double> widthOfColumns);

typedef TekReorderableCustomizeTitleWidget = Widget Function(
  BuildContext context,
  String columnKey,
  String? columnName,
  double? width,
  List<TekScreenDevice>? showOnScreens,
);

typedef TekReorderableTableItemWidget<T> = Widget Function(
  BuildContext context,
  dynamic value,
  T rowData,
  String columnKey,
  String? columnName,
  double? width,
  List<TekScreenDevice>? showOnScreens,
);

typedef TekReorderableHandleFilterDataFunction<T> = void Function({
  required List<T> dataSources,
  int? totalRecords,
  int? currentPage,
  int? itemsPerPage,
  int? pageNumber,
});

typedef TekReorderableCustomizeFilterWidget<T> = Widget Function(
  BuildContext context,
  String columnKey,
  String? columnName,
  bool enableFilter,
  bool isShowMenu,
  ValueChanged<bool> changeFilter,
  ValueChanged<bool> changeShowMenu,
  TekReorderableHandleFilterDataFunction<T> handleFilterData,
);

typedef TekReorderableSortDataVoid<T> = void Function(
  String keyColumn,
  TekDataTableReorderableSortType typeSort,
  TekReorderableHandleFilterDataFunction<T> handleFilterData,
);

typedef TekReorderableAsyncDataSource<T> = void Function({
  required int currentPage,
  required int itemsPerPage,
});

typedef TekReorderableOnReorderVoid<T> = void Function(int oldIndex, int newIndex);

typedef TekReorderableOnNoReorderVoid<T> = void Function(int index);

typedef TekReorderableOnReorderStartedVoid<T> = void Function(int index);
