part of '../data_table.dart';

class DataTableFixedColumnContentWidget<T> extends StatefulWidget {
  const DataTableFixedColumnContentWidget({
    Key? key,
    required this.type,
    required this.controller,
    required this.rowOption,
    required this.checkBoxOption,
  }) : super(key: key);

  final TekFixedColumn type;
  final TekDataTableController<T> controller;
  final TekDataTableCheckBoxOption<T> checkBoxOption;
  final TekDataTableRowOption<T> rowOption;

  @override
  State<DataTableFixedColumnContentWidget<T>> createState() =>
      _DataTableFixedColumnContentWidgetState<T>();
}

class _DataTableFixedColumnContentWidgetState<T>
    extends State<DataTableFixedColumnContentWidget<T>> {
  late final StreamSubscription<TekEventReloadFixedColumn> _listener;

  @override
  void initState() {
    super.initState();
    _listener = widget.controller.reloadFixedColumnStreamController.stream.listen(
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _listener.pause();
    _listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.type == TekFixedColumn.left
          ? widget.controller.widthOfLeftColumns
          : widget.controller.widthOfRightColumns,
      child: TekDataTableContentWidget<T>(
        tableColumns: widget.type == TekFixedColumn.left
            ? widget.controller.fixedColumnsLeft
            : widget.controller.fixedColumnsRight,
        fixedColumn: widget.type,
        controller: widget.controller,
        rowOption: widget.rowOption,
        checkBoxOption: widget.checkBoxOption,
      ),
    );
  }
}
