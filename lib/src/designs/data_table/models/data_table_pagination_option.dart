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
    this.decoration,
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
  final TekDataTablePaginationDecoration? decoration;
}

/// Support setting decoration for header item
/// [backgroundColor] is background color of pagination
/// [borderRadius] is border radius of pagination
/// [border] is border of pagination
///
/// If you want to set decoration for pagination, you must set [TekDataTablePaginationOption] for [TekDataTablePaginationDecoration]
/// and set [TekDataTableHeaderDecoration] for each [DataTableColumn]
class TekDataTablePaginationDecoration {
  const TekDataTablePaginationDecoration({
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.iconColor,
    this.itemPerPageColor,
    this.backgroundColorItemPage,
    this.textColorItemPage,
    this.backgroundColorItemPageOnSelected,
    this.textColorItemPageOnSelected,
  });

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? iconColor;
  final Color? itemPerPageColor;
  final Color? backgroundColorItemPage;
  final Color? textColorItemPage;
  final Color? backgroundColorItemPageOnSelected;
  final Color? textColorItemPageOnSelected;
}
