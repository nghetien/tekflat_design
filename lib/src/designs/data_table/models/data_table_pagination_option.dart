part of '../data_table.dart';

class TekDataTablePaginationOption {
  const TekDataTablePaginationOption({
    this.customizeItemPerPage = 'Item per page',
    this.customizeFromToItemInPage,
    this.isShowPagination = true,
    this.enableItemPerPage = true,
    this.borderRadius,
  });

  final String customizeItemPerPage;
  final String Function(int, int, int)? customizeFromToItemInPage;
  final bool isShowPagination;
  final bool enableItemPerPage;
  final Radius? borderRadius;
}
