part of 'data_table.dart';

class DataTableState<T> {
  DataTableState({
    List<T>? dataSources,
    int? totalRecords,
    Map<int, T>? dataSelected,
  })  : dataSources = dataSources ?? <T>[],
        totalRecords = totalRecords ?? 0,
        dataSelected = dataSelected ?? <int, T>{};

  late List<T> dataSources;
  late int totalRecords;
  TekDataTablePagination pagination = TekDataTablePagination();

  // Map giữa id và data
  late Map<int, T> dataSelected; // Sử dụng khi DataTableAdditionColumn là checkbox

  double? widthOfColumnsContent;
  List<DataTableColumn<T>> tableColumnsContent = [];
  List<DataTableColumn<T>> fixedColumnsLeft = [];
  List<DataTableColumn<T>> fixedColumnsRight = [];

  Map<int, double?> mapIndexToHeightOfEachRow = {};

  Map<String, double> mapKeyToWidthOfEachColumnContent = {};

  bool isLoading = false;
}
