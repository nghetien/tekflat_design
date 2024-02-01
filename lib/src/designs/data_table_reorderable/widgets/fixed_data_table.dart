part of '../data_table_reorderable.dart';

class TekFixedDataTableReorderableWidget<T> extends StatefulWidget {
  const TekFixedDataTableReorderableWidget({
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
    required this.onReorder,
    this.onNoReorder,
    this.onReorderStarted,
  }) : super(key: key);

  final TekDataTableReorderableController<T> controller;
  final TekReorderableOptionContentTable? topContent;
  final TekReorderableOptionContentTable? bottomContent;
  final TekReorderableShowerMoreContentIntoRowWidget<T>? showerMoreContentIntoRowWidget;
  final TekReorderableHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekReorderableAsyncDataSource<T>? handleChangeData;
  final TekDataTableReorderableHeaderOption headerOption;
  final TekDataTableReorderableRowOption<T> rowOption;
  final TekDataTableReorderableColumnOption columnOption;
  final TekDataTableReorderablePaginationOption paginationOption;
  final TekDataTableReorderableCheckBoxOption<T> checkBoxOption;
  final TekDataTableReorderableScrollOption scrollOption;
  final TekReorderableOnReorderVoid<T> onReorder;
  final TekReorderableOnNoReorderVoid<T>? onNoReorder;
  final TekReorderableOnReorderStartedVoid<T>? onReorderStarted;

  @override
  State<TekFixedDataTableReorderableWidget<T>> createState() =>
      _TekFixedDataTableReorderableWidgetState<T>();
}

class _TekFixedDataTableReorderableWidgetState<T>
    extends State<TekFixedDataTableReorderableWidget<T>> {
  final ScrollController _verticalScrollController = ScrollController(),
      _horizontalScrollController = ScrollController();

  final GlobalKey<TekVerticalScrollState> _keyVerticalScroll = GlobalKey<TekVerticalScrollState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                                          TekDataTableReorderableHeaderWidget<T>(
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
                                                child: TekDataTableReorderableContentWidget<T>(
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
                                                  onReorder: widget.onReorder,
                                                  onNoReorder: widget.onNoReorder,
                                                  onReorderStarted: widget.onReorderStarted,
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
                        ],
                      ),
                      if (scrollVerticalWidget != null)
                        Positioned(
                          right: 0,
                          top: widget.headerOption.heightOfHeaderItem ??
                              TekDataTableReorderableHeaderWidget.defaultHeightHeader,
                          child: scrollVerticalWidget,
                        ),
                    ],
                  ),
                ),
                if (scrollHorizontalWidget != null) scrollHorizontalWidget,
                if (widget.paginationOption.isShowPagination ||
                    widget.paginationOption.enableItemPerPage)
                  TekDataTableReorderablePaginationWidget<T>(
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
