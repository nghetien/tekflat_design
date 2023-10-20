part of '../data_table.dart';

class TekFixedDataTableWidget<T> extends StatefulWidget {
  const TekFixedDataTableWidget({
    Key? key,
    required this.controller,
    this.topContent,
    this.bottomContent,
    this.showerMoreContentIntoRowWidget,
    this.headerIntoRowWidget,
    this.handleChangeData,
    required this.headerOption,
    required this.rowOption,
    required this.columnOption,
    required this.paginationOption,
    required this.checkBoxOption,
    required this.scrollOption,
  }) : super(key: key);

  final TekDataTableController<T> controller;
  final TekOptionContentTable? topContent;
  final TekOptionContentTable? bottomContent;
  final TekShowerMoreContentIntoRowWidget<T>? showerMoreContentIntoRowWidget;
  final TekHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekAsyncDataSource<T>? handleChangeData;
  final TekDataTableHeaderOption headerOption;
  final TekDataTableRowOption<T> rowOption;
  final TekDataTableColumnOption columnOption;
  final TekDataTablePaginationOption paginationOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;
  final TekDataTableScrollOption scrollOption;

  @override
  State<TekFixedDataTableWidget<T>> createState() => _TekFixedDataTableWidgetState<T>();
}

class _TekFixedDataTableWidgetState<T> extends State<TekFixedDataTableWidget<T>> {
  final ScrollController _verticalScrollController = ScrollController(),
      _horizontalScrollController = ScrollController(),
      _verticalFixedColumnLeftScrollController = ScrollController(),
      _verticalFixedColumnRightScrollController = ScrollController();

  final GlobalKey<TekVerticalScrollState> _keyVerticalScroll =
      GlobalKey<TekVerticalScrollState>();

  bool _isListening = false;

  void _listenVerticalScroll() {
    if (_isListening) return;
    _isListening = true;
    if (widget.controller.haveFixedColumnsLeft) {
      _verticalFixedColumnLeftScrollController.jumpTo(_verticalScrollController.offset);
    }
    if (widget.controller.haveFixedColumnsRight) {
      _verticalFixedColumnRightScrollController.jumpTo(_verticalScrollController.offset);
    }
    _isListening = false;
  }

  void _listenVerticalFixedColumnLeftScroll() {
    if (_isListening) return;
    _isListening = true;
    _verticalScrollController.jumpTo(_verticalFixedColumnLeftScrollController.offset);
    if (widget.controller.haveFixedColumnsRight) {
      _verticalFixedColumnRightScrollController
          .jumpTo(_verticalFixedColumnLeftScrollController.offset);
    }
    _isListening = false;
  }

  void _listenVerticalFixedColumnRightScroll() {
    if (_isListening) return;
    _isListening = true;
    _verticalScrollController.jumpTo(_verticalFixedColumnRightScrollController.offset);
    if (widget.controller.haveFixedColumnsLeft) {
      _verticalFixedColumnLeftScrollController
          .jumpTo(_verticalFixedColumnRightScrollController.offset);
    }
    _isListening = false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller.haveFixedColumnsLeft || widget.controller.haveFixedColumnsRight) {
      _verticalScrollController.addListener(_listenVerticalScroll);
    }
    if (widget.controller.haveFixedColumnsLeft) {
      _verticalFixedColumnLeftScrollController.addListener(_listenVerticalFixedColumnLeftScroll);
    }
    if (widget.controller.haveFixedColumnsRight) {
      _verticalFixedColumnRightScrollController.addListener(_listenVerticalFixedColumnRightScroll);
    }
  }

  @override
  void dispose() {
    if (widget.controller.haveFixedColumnsLeft || widget.controller.haveFixedColumnsRight) {
      _verticalScrollController.removeListener(_listenVerticalScroll);
    }
    if (widget.controller.haveFixedColumnsLeft) {
      _verticalFixedColumnLeftScrollController.removeListener(_listenVerticalFixedColumnLeftScroll);
    }
    if (widget.controller.haveFixedColumnsRight) {
      _verticalFixedColumnRightScrollController
          .removeListener(_listenVerticalFixedColumnRightScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TekVerticalScroll(
      key: _keyVerticalScroll,
      scrollController: _verticalScrollController,
      backgroundColor: widget.scrollOption.backgroundColor,
      scrollColor: widget.scrollOption.scrollColor,
      builder: (
        _,
        TekVerticalScrollWrapperContent wrapperVerticalContent,
        Widget? scrollVerticalWidget,
      ) =>
          LayoutBuilder(
        builder: (_, constrainsSize) {
          return TekHorizontalScroll(
            scrollHeight: 10,
            scrollHeightOnHover: 13,
            maxScroll: constrainsSize.maxWidth,
            scrollController: _horizontalScrollController,
            backgroundColor: widget.scrollOption.backgroundColor,
            scrollColor: widget.scrollOption.scrollColor,
            builder: (
              _,
              TekHorizontalScrollWrapperContent wrapperHorizontalContent,
              Widget? scrollHorizontalWidget,
            ) =>
                Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (widget.controller.haveFixedColumnsLeft)
                            SizedBox(
                              width: widget.controller.widthOfLeftColumns,
                              child: TekFixedColumnForFixedTable<T>(
                                type: TekFixedColumn.left,
                                controller: widget.controller,
                                verticalFixedColumnScrollController:
                                    _verticalFixedColumnLeftScrollController,
                                rowOption: widget.rowOption,
                                checkBoxOption: widget.checkBoxOption,
                                headerOption: widget.headerOption,
                              ),
                            ),
                          Expanded(
                            child: wrapperHorizontalContent(
                              LayoutBuilder(
                                builder: (_, constrains) {
                                  widget.controller.setWidthOfColumnsContent(constrains.maxWidth);
                                  widget.controller.calculateWidthOfAllColumnsContent();
                                  return SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    controller: _horizontalScrollController,
                                    child: SizedBox(
                                      width: widget.controller.widthOfColumnsContent,
                                      child: Column(
                                        children: <Widget>[
                                          TekDataTableHeaderWidget<T>(
                                            tableColumns: widget.controller.tableColumnsContent,
                                            controller: widget.controller,
                                            headerOption: widget.headerOption,
                                            checkBoxOption: widget.checkBoxOption,
                                          ),
                                          Expanded(
                                            child: wrapperVerticalContent(
                                              SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                controller: _verticalScrollController,
                                                child: TekDataTableContentWidget<T>(
                                                  tableColumns:
                                                      widget.controller.tableColumnsContent,
                                                  verticalScrollState:
                                                      _keyVerticalScroll.currentState,
                                                  controller: widget.controller,
                                                  topContent: widget.topContent,
                                                  bottomContent: widget.bottomContent,
                                                  showerMoreContentRowWidget:
                                                      widget.showerMoreContentIntoRowWidget,
                                                  headerIntoRowWidget: widget.headerIntoRowWidget,
                                                  checkBoxOption: widget.checkBoxOption,
                                                  rowOption: widget.rowOption,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          if (widget.controller.haveFixedColumnsRight)
                            SizedBox(
                              width: widget.controller.widthOfRightColumns,
                              child: TekFixedColumnForFixedTable<T>(
                                type: TekFixedColumn.right,
                                controller: widget.controller,
                                verticalFixedColumnScrollController:
                                    _verticalFixedColumnRightScrollController,
                                rowOption: widget.rowOption,
                                checkBoxOption: widget.checkBoxOption,
                                headerOption: widget.headerOption,
                              ),
                            ),
                        ],
                      ),
                      if (scrollVerticalWidget != null)
                        Positioned(
                          right: 0,
                          top: widget.headerOption.heightOfHeaderItem ??
                              TekDataTableHeaderWidget.defaultHeightHeader,
                          child: scrollVerticalWidget,
                        ),
                    ],
                  ),
                ),
                if (scrollHorizontalWidget != null) scrollHorizontalWidget,
                if (widget.paginationOption.isShowPagination ||
                    widget.paginationOption.enableItemPerPage)
                  TekDataTablePaginationWidget<T>(
                    controller: widget.controller,
                    handleChangeData: widget.handleChangeData,
                    paginationOption: widget.paginationOption,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
