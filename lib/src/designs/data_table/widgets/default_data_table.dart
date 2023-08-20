part of '../data_table.dart';

class TekDefaultDataTableWidget<T> extends StatefulWidget {
  const TekDefaultDataTableWidget({
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

  @override
  State<TekDefaultDataTableWidget<T>> createState() => _TekDefaultDataTableWidgetState<T>();
}

class _TekDefaultDataTableWidgetState<T> extends State<TekDefaultDataTableWidget<T>> {
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrainsSize) => TekHorizontalScroll(
        scrollHeight: 10,
        scrollHeightOnHover: 13,
        maxScroll: constrainsSize.maxWidth,
        scrollController: _horizontalScrollController,
        builder: (
          _,
          TekHorizontalScrollWrapperContent wrapperHorizontalContent,
          Widget? scrollHorizontalWidget,
        ) =>
            Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (widget.controller.haveFixedColumnsLeft)
                  SizedBox(
                    width: widget.controller.widthOfLeftColumns,
                    child: TekDataTableFixedColumnWidget<T>(
                      type: TekFixedColumn.left,
                      controller: widget.controller,
                      headerOption: widget.headerOption,
                      checkBoxOption: widget.checkBoxOption,
                      rowOption: widget.rowOption,
                    ),
                  ),
                Expanded(
                  child: wrapperHorizontalContent(
                    LayoutBuilder(builder: (_, constrains) {
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
                                checkBoxOption: widget.checkBoxOption,
                                headerOption: widget.headerOption,
                              ),
                              TekDataTableContentWidget<T>(
                                tableColumns: widget.controller.tableColumnsContent,
                                controller: widget.controller,
                                topContent: widget.topContent,
                                bottomContent: widget.bottomContent,
                                showerMoreContentRowWidget: widget.showerMoreContentIntoRowWidget,
                                headerIntoRowWidget: widget.headerIntoRowWidget,
                                checkBoxOption: widget.checkBoxOption,
                                rowOption: widget.rowOption,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                if (widget.controller.haveFixedColumnsRight)
                  SizedBox(
                    width: widget.controller.widthOfRightColumns,
                    child: TekDataTableFixedColumnWidget<T>(
                      type: TekFixedColumn.right,
                      controller: widget.controller,
                      rowOption: widget.rowOption,
                      checkBoxOption: widget.checkBoxOption,
                      headerOption: widget.headerOption,
                    ),
                  ),
              ],
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
      ),
    );
  }
}
