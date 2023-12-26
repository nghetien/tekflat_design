part of 'data_table_reorderable.dart';

class DataTableReorderableState<T> {
  DataTableReorderableState({
    List<T>? dataSources,
    int? totalRecords,
    Map<int, T>? dataSelected,
  })  : dataSources = dataSources ?? <T>[],
        totalRecords = totalRecords ?? 0,
        dataSelected = dataSelected ?? <int, T>{};

  late List<T> dataSources;
  late int totalRecords;
  TekDataTableReorderablePagination pagination = TekDataTableReorderablePagination();

  // Map giữa id và data
  late Map<int, T> dataSelected; // Sử dụng khi DataTableAdditionColumn là checkbox

  double? widthOfColumnsContent;
  bool isWidthColumnLargeThanWidthTable = false;
  List<DataTableReorderableColumn<T>> tableColumnsContent = [];

  Map<int, double?> mapIndexToHeightOfEachRow = {};

  Map<String, double> mapKeyToWidthOfEachColumnContent = {};

  bool isLoading = false;
}
