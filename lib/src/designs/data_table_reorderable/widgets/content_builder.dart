part of '../data_table_reorderable.dart';

class TekDataTableReorderableContentBuilder<T> extends StatelessWidget {
  const TekDataTableReorderableContentBuilder({
    super.key,
    required this.controller,
    required this.tableColumns,
    required this.rowOption,
    required this.onShowMore,
    required this.onClickContent,
    this.showerMoreContentRowWidget,
    this.headerIntoRowWidget,
    required this.checkBoxOption,
    required this.onReorder,
    this.onNoReorder,
    this.onReorderStarted,
  });

  final TekDataTableReorderableController<T> controller;
  final List<DataTableReorderableColumn<T>> tableColumns;
  final TekDataTableReorderableRowOption<T> rowOption;
  final bool Function(int) onShowMore;
  final Function(int, T) onClickContent;
  final TekShowerMoreContentIntoRowWidget<T>? showerMoreContentRowWidget;
  final TekHeaderIntoRowWidget<T>? headerIntoRowWidget;
  final TekDataTableReorderableCheckBoxOption<T> checkBoxOption;
  final TekReorderableOnReorderVoid<T> onReorder;
  final TekReorderableOnNoReorderVoid<T>? onNoReorder;
  final TekReorderableOnReorderStartedVoid<T>? onReorderStarted;

  double? getHeightOfRow(int index) {
    if (rowOption.heightOfRowItem != null) {
      return rowOption.heightOfRowItem;
    }
    return null;
  }

  void _onReorder(int oldIndex, int newIndex) {
    onReorder(oldIndex, newIndex);
  }

  void _onNoReorder(int index) {
    onNoReorder?.call(index);
  }

  void _onReorderStarted(int index) {
    onReorderStarted?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableColumn(
      padding: EdgeInsets.zero,
      onReorder: _onReorder,
      onNoReorder: _onNoReorder,
      onReorderStarted: _onReorderStarted,
      draggingWidgetOpacity: 1,
      buildDraggableFeedback: (_, constraints, child) {
        return Transform(
          transform: Matrix4.rotationZ(0),
          alignment: FractionalOffset.topLeft,
          child: Material(
            elevation: 10,
            color: Colors.transparent,
            borderRadius: BorderRadius.zero,
            child: TekCard(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.zero,
              child: ConstrainedBox(
                constraints: constraints,
                child: child,
              ),
            ),
          ),
        );
      },
      children: _contentsWidget(),

    );
  }

  List<Widget> _contentsWidget() {
    final List<Widget> contents = [];
    for (int index = 0; index < controller.dataSources.length; index++) {
      final T rowData = controller.dataSources[index];
      contents.add(
        Container(
          key: ObjectKey(rowData),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 0, color: TekColors().greyOpacity01),
              left: BorderSide(width: 0, color: TekColors().greyOpacity01),
            ),
          ),
          child: TekDataTableReorderableRowWidget<T>(
            tableColumns: tableColumns,
            height: getHeightOfRow(index),
            controller: controller,
            indexRow: index,
            rowData: rowData,
            isShowMore: onShowMore(index),
            onPressed: onClickContent(index, rowData),
            showerMoreContentRowWidget: showerMoreContentRowWidget,
            headerIntoRowWidget: headerIntoRowWidget,
            rowOption: rowOption,
            checkBoxOption: checkBoxOption,
          ),
        ),
      );
    }
    return contents;
  }
}
