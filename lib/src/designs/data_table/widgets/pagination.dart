part of '../data_table.dart';

class TekDataTablePaginationWidget<T> extends StatefulWidget {
  const TekDataTablePaginationWidget({
    Key? key,
    this.handleChangeData,
    required this.controller,
    required this.paginationOption,
  }) : super(key: key);

  final TekDataTableController<T> controller;
  final TekAsyncDataSource<T>? handleChangeData;
  final TekDataTablePaginationOption paginationOption;

  @override
  State<TekDataTablePaginationWidget> createState() => _TekDataTablePaginationWidgetState();
}

class _TekDataTablePaginationWidgetState extends State<TekDataTablePaginationWidget> {
  TekDataTablePagination get pagination => widget.controller.pagination;

  static const int threeDotFlagNumber = 0;

  void _handleChangeDataPageNumber(int pageNumber) {
    if (pageNumber == pagination.currentPage) return;
    widget.controller.setCurrentPage(pageNumber);
    if (widget.controller.additionColumns.contains(TekDataTableAdditionColumn.checkbox)) {
      widget.controller.clearSelected();
    }
    widget.handleChangeData?.call(
      currentPage: pagination.currentPage,
      itemsPerPage: pagination.itemsPerPage,
    );
  }

  void _handleChangeDataPageLeft(bool isBackToTheFirst) {
    if (isBackToTheFirst) {
      _handleChangeDataPageNumber(1);
      return;
    }
    if (pagination.currentPage > 1) _handleChangeDataPageNumber(pagination.currentPage - 1);
  }

  void _handleChangeDataPageRight(bool isBackToTheEnd) {
    if (isBackToTheEnd) {
      _handleChangeDataPageNumber(pagination.pageNumber);
      return;
    }
    if (pagination.currentPage < pagination.pageNumber) {
      _handleChangeDataPageNumber(pagination.currentPage + 1);
    }
  }

  void _handleChangeItemPerPage(int? itemPerPage) {
    if (itemPerPage == null) return;
    widget.controller.setCurrentPage(1);
    widget.controller.setItemsPerPage(itemPerPage);
    widget.controller.setPageNumber(widget.controller.calculatePageNumber(itemPerPage));
    widget.handleChangeData?.call(
      currentPage: pagination.currentPage,
      itemsPerPage: pagination.itemsPerPage,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.calculatePagination();
    return LayoutBuilder(
      builder: (_, constrains) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: TekSpacings().p8,
          vertical: TekSpacings().p4 / 2,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: TekColors().primary,
          borderRadius: BorderRadius.only(
            bottomLeft: widget.paginationOption.borderRadius ?? TekCorners().mainCornerRadius,
            bottomRight: widget.paginationOption.borderRadius ?? TekCorners().mainCornerRadius,
          ),
        ),
        child: widget.paginationOption.isShowPagination
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _nextPageLeft(),
                        _pageNumberWidget(),
                        _nextPageRight(),
                        TekHSpace.p14,
                        _dropdownItemsPerPage(),
                      ],
                    ),
                  ),
                  if (TekResponsiveConfig().screenDevice.isDesktop) _fromToItemsInPage(),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _fromToItemsInPage(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _nextPageLeft() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (!TekPlatform.isMobile)
          IconButton(
            onPressed: () => _handleChangeDataPageLeft(true),
            icon: Icon(
              Icons.keyboard_double_arrow_left_rounded,
              color: TekColors().white,
            ),
          ),
        IconButton(
          onPressed: () => _handleChangeDataPageLeft(false),
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: TekColors().white,
          ),
        ),
      ],
    );
  }

  Widget _customBtnPageNumber({
    required int number,
    required VoidCallback onPressed,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: TekSpacings().p4),
        child: TekButton(
          height: 25,
          size: TekButtonSize.small,
          onPressed: onPressed,
          text: number > 0 ? number.toString() : '...',
          padding: EdgeInsets.symmetric(horizontal: TekSpacings().p8),
          textStyle: TextStyle(
            color: number == pagination.currentPage ? TekColors().primary : TekColors().white,
          ),
          background: number == pagination.currentPage ? TekColors().white : TekColors().primary,
        ),
      );

  Widget _pageNumberWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (pagination.currentPage - pagination.numberNextPage - pagination.excessStart - 1 > 0)
          _customBtnPageNumber(
            onPressed: () => _handleChangeDataPageNumber(
              pagination.currentPage - pagination.numberNextPage - pagination.excessStart - 1,
            ),
            number: threeDotFlagNumber,
          ),
        for (int number = pagination.startPage; number < pagination.endPage + 1; number++)
          _customBtnPageNumber(
            onPressed: () => _handleChangeDataPageNumber(number),
            number: number,
          ),
        if (pagination.currentPage + pagination.numberNextPage + pagination.excessEnd <
            pagination.pageNumber)
          _customBtnPageNumber(
            onPressed: () => _handleChangeDataPageNumber(
              pagination.currentPage + pagination.numberNextPage + pagination.excessEnd + 1,
            ),
            number: threeDotFlagNumber,
          )
      ],
    );
  }

  Widget _nextPageRight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () => _handleChangeDataPageRight(false),
          icon: Icon(
            Icons.keyboard_arrow_right_rounded,
            color: TekColors().white,
          ),
        ),
        if (!TekPlatform.isMobile)
          IconButton(
            onPressed: () => _handleChangeDataPageRight(true),
            icon: Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: TekColors().white,
            ),
          ),
      ],
    );
  }

  Widget _dropdownItemsPerPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          child: TekInputDropdown<int>(
            width: 75,
            valueSingle: pagination.itemsPerPage.toString(),
            contentPadding: EdgeInsets.only(
              left: TekSpacings().p8,
              top: TekSpacings().p4,
              bottom: TekSpacings().p4,
            ),
            menuChildren: [
              for (final item in pagination.listItemsPerPage)
                TekInputDropdownItemModel<int>(
                  keyValue: item.toString(),
                  value: item,
                  label: item.toString(),
                ),
            ],
            onChangedSingle: (item) {
              _handleChangeItemPerPage(item);
            },
            ableClearValue: false,
          ),
        ),
        if (TekResponsiveConfig().screenDevice.isDesktop)
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: TekSpacings().p8),
              child: Text(
                widget.paginationOption.customizeItemPerPage,
                style: TextStyle(
                  color: TekColors().white,
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _fromToItemsInPage() {
    final fromItem = (pagination.currentPage - 1) * pagination.itemsPerPage;
    final toItem = pagination.currentPage * pagination.itemsPerPage;
    final int toItemStr =
        toItem > widget.controller.totalRecords ? widget.controller.totalRecords : toItem;
    final int fromItemStr = fromItem > 0
        ? fromItem
        : toItemStr == 0
            ? 0
            : 1;
    final int totalRecords = widget.controller.totalRecords;
    return Text(
      widget.paginationOption.isShowPagination
          ? (widget.paginationOption.customizeFromToItemInPage != null
              ? widget.paginationOption.customizeFromToItemInPage!(
                  fromItem,
                  toItem > widget.controller.totalRecords ? widget.controller.totalRecords : toItem,
                  widget.controller.totalRecords,
                )
              : '$fromItemStr - $toItemStr of $totalRecords items')
          : '$totalRecords items',
      style: TextStyle(
        color: TekColors().white,
      ),
    );
  }
}
