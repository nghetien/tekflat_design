part of '../data_table.dart';

class TekDataTablePaginationOption {
  const TekDataTablePaginationOption({
    this.customizeItemPerPage = 'Item per page',
    this.customizeFromToItemInPage,
    this.isShowPagination = true,
    this.enableItemPerPage = true,
    this.borderRadius,
    this.listItemsPerPage,
    this.itemsPerPage,
    this.numberNextPage,
    this.currentPage,
    this.inputDecorationTheme,
  });

  final String customizeItemPerPage;
  final String Function(int, int, int)? customizeFromToItemInPage;
  final bool isShowPagination;
  final bool enableItemPerPage;
  final Radius? borderRadius;
  final List<int>? listItemsPerPage;
  final int? itemsPerPage;
  final int? numberNextPage;
  final int? currentPage;

  // ui
  final InputDecorationTheme? inputDecorationTheme;
}
