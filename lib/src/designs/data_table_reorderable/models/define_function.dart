part of '../data_table_reorderable.dart';

enum TekDataTableSortType { asc, desc, none }

typedef TekShowerMoreContentIntoRowWidget<T> = Widget Function(T rowData);

typedef TekHeaderIntoRowWidget<T> = Widget? Function(T rowData, Map<String, double> widthOfColumns);

typedef TekOptionContentTable = Widget Function(
    List<DataTableReorderableColumn> columns, Map<String, double> widthOfColumns);

typedef TekCustomizeTitleWidget = Widget Function(
  BuildContext context,
  String columnKey,
  String? columnName,
  double? width,
  List<TekScreenDevice>? showOnScreens,
);

typedef TekTableItemWidget<T> = Widget Function(
  BuildContext context,
  dynamic value,
  T rowData,
  String columnKey,
  String? columnName,
  double? width,
  List<TekScreenDevice>? showOnScreens,
);

typedef TekHandleFilterDataFunction<T> = void Function({
  required List<T> dataSources,
  int? totalRecords,
  int? currentPage,
  int? itemsPerPage,
  int? pageNumber,
});

typedef TekCustomizeFilterWidget<T> = Widget Function(
  BuildContext context,
  String columnKey,
  String? columnName,
  bool enableFilter,
  bool isShowMenu,
  ValueChanged<bool> changeFilter,
  ValueChanged<bool> changeShowMenu,
  TekHandleFilterDataFunction<T> handleFilterData,
);

typedef TekSortDataVoid<T> = void Function(
  String keyColumn,
  TekDataTableSortType typeSort,
  TekHandleFilterDataFunction<T> handleFilterData,
);

typedef TekAsyncDataSource<T> = void Function({
  required int currentPage,
  required int itemsPerPage,
});

typedef TekReorderableOnReorderVoid<T> = void Function(int oldIndex, int newIndex);

typedef TekReorderableOnNoReorderVoid<T> = void Function(int index);

typedef TekReorderableOnReorderStartedVoid<T> = void Function(int index);
