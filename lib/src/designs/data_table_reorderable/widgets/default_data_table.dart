part of '../data_table_reorderable.dart';

class TekDefaultDataTableReorderableWidget<T> extends StatefulWidget {
  const TekDefaultDataTableReorderableWidget({
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
  final TekOptionContentTable? topContent;
  final TekOptionContentTable? bottomContent;
  final TekShowerMoreContentIntoRowWidget<T>? showerMoreContentIntoRowWidget;
  final TekHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekAsyncDataSource<T>? handleChangeData;
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
  State<TekDefaultDataTableReorderableWidget<T>> createState() =>
      _TekDefaultDataTableReorderableWidgetState<T>();
}

class _TekDefaultDataTableReorderableWidgetState<T>
    extends State<TekDefaultDataTableReorderableWidget<T>> {
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrainsSize) => TekHorizontalScroll(
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
          children: [
            wrapperHorizontalContent(
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
                            checkBoxOption: widget.checkBoxOption,
                            headerOption: widget.headerOption,
                          ),
                          TekDataTableReorderableContentWidget<T>(
                            tableColumns: widget.controller.tableColumnsContent,
                            controller: widget.controller,
                            topContent: widget.topContent,
                            bottomContent: widget.bottomContent,
                            showerMoreContentRowWidget: widget.showerMoreContentIntoRowWidget,
                            headerIntoRowWidget: widget.headerIntoRowWidget,
                            checkBoxOption: widget.checkBoxOption,
                            rowOption: widget.rowOption,
                            onReorder: widget.onReorder,
                            onNoReorder: widget.onNoReorder,
                            onReorderStarted: widget.onReorderStarted,
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
      ),
    );
  }
}
