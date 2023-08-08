part of '../data_table.dart';

class TekDataTablePagination {
  static const int defaultItemsPerPage = 12;
  static const List<int> defaultListItemsPerPage = [12, 24, 48, 96];

  static int get getNumberNextPage {
    switch (TekResponsiveConfig().screenDevice) {
      case TekScreenDevice.mobile:
        return 1;
      case TekScreenDevice.tablet:
        return 2;
      case TekScreenDevice.desktop:
        return 3;
    }
  }

  TekDataTablePagination({
    int? pageNumber,
    int? itemsPerPage,
    List<int>? listItemsPerPage,
    int? numberNextPage,
    int? currentPage,
  })  : pageNumber = pageNumber ?? 1,
        itemsPerPage = itemsPerPage ?? defaultItemsPerPage,
        listItemsPerPage = listItemsPerPage ?? defaultListItemsPerPage,
        numberNextPage = numberNextPage ?? getNumberNextPage,
        currentPage = currentPage ?? 1;

  /// init data
  int pageNumber;
  int itemsPerPage;
  List<int> listItemsPerPage;
  int numberNextPage;

  /// handle data
  int currentPage = 1;
  int excessStart = 0;
  int excessEnd = 0;
  int startPage = 0;
  int endPage = 0;

  void setListItemsPerPage(List<int>? listItemsPerPage) {
    if (listItemsPerPage != null && listItemsPerPage.isNotEmpty) {
      listItemsPerPage = listItemsPerPage;
    }
  }

  /// logic
  void calculatePagination() {
    excessStart = currentPage - numberNextPage <= 0 ? numberNextPage - (currentPage - 1) : 0;
    excessEnd = currentPage + numberNextPage >= pageNumber
        ? numberNextPage - (pageNumber - currentPage)
        : 0;
    startPage = currentPage - numberNextPage <= 0 ? 1 : currentPage - numberNextPage - excessStart;
    endPage = currentPage + numberNextPage >= pageNumber
        ? pageNumber
        : currentPage + numberNextPage + excessEnd;
  }
}
