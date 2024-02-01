part of '../data_table_reorderable.dart';

class TekDataTableReorderableHeaderItemWidget<T> extends StatefulWidget {
  const TekDataTableReorderableHeaderItemWidget({
    Key? key,
    required this.index,
    required this.lengthOfColumn,
    required this.controller,
    required this.column,
    required this.headerOption,
    required this.checkBoxOption,
    required this.sortType,
    required this.onSelectSortType,
  }) : super(key: key);

  final int index;
  final int lengthOfColumn;
  final TekDataTableReorderableController<T> controller;
  final DataTableReorderableColumn<T> column;
  final TekDataTableReorderableHeaderOption headerOption;
  final TekDataTableReorderableCheckBoxOption<T> checkBoxOption;
  final MapEntry<String, TekDataTableReorderableSortType> sortType;
  final ValueChanged<MapEntry<String, TekDataTableReorderableSortType>> onSelectSortType;

  @override
  State<TekDataTableReorderableHeaderItemWidget<T>> createState() => _TekDataTableReorderableHeaderItemWidgetState<T>();
}

class _TekDataTableReorderableHeaderItemWidgetState<T> extends State<TekDataTableReorderableHeaderItemWidget<T>> {
  final MenuController _menuController = MenuController();
  bool _enableFilter = false;
  bool _isShowMenu = false;

  bool get enableFilter => _enableFilter;

  bool get isShowMenu => _isShowMenu;

  void _setEnableFilter(bool value) => setState(() => _enableFilter = value);

  void _setIsShowMenu(bool value) => _isShowMenu = value;

  void _handleChangeSortType() {
    late TekDataTableReorderableSortType type;
    if (widget.column.key != widget.sortType.key) {
      type = TekDataTableReorderableSortType.asc;
      widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableReorderableSortType.asc));
    } else {
      switch (widget.sortType.value) {
        case TekDataTableReorderableSortType.none:
          type = TekDataTableReorderableSortType.asc;
          widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableReorderableSortType.asc));
          break;
        case TekDataTableReorderableSortType.asc:
          type = TekDataTableReorderableSortType.desc;
          widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableReorderableSortType.desc));
          break;
        case TekDataTableReorderableSortType.desc:
          type = TekDataTableReorderableSortType.none;
          widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableReorderableSortType.none));
          break;
      }
    }
    widget.column.sortDataVoid?.call(
      widget.column.key,
      type,
      _handleFilterData,
    );
  }

  void _handleChangeShowMenu(bool value) {
    _setIsShowMenu(value);
    if (value) {
      _menuController.open();
    } else {
      _menuController.close();
    }
  }

  void _handleFilterData({
    required List<T> dataSources,
    int? totalRecords,
    int? currentPage,
    int? itemsPerPage,
    int? pageNumber,
  }) {
    widget.controller.setDataSources(dataSources);
    if (totalRecords != null) widget.controller.setTotalRecords(totalRecords);
    if (currentPage != null) widget.controller.setCurrentPage(currentPage);
    if (itemsPerPage != null) widget.controller.setItemsPerPage(itemsPerPage);
    if (pageNumber != null) widget.controller.setPageNumber(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.controller.mapKeyToWidthOfEachColumnContent[widget.column.key],
      height: widget.headerOption.heightOfHeaderItem ?? TekDataTableReorderableHeaderWidget.defaultHeightHeader,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: widget.index < widget.lengthOfColumn - 1
                ? BorderSide(
                    color: TekColors().greyOpacity04,
                    width: TekBorders.thin,
                  )
                : BorderSide.none,
          ),
        ),
        child: _getWidgetHeaderItem(context),
      ),
    );
  }

  Widget _getWidgetHeaderItem(BuildContext context) {
    final headerTextColors = widget.headerOption.headerTextColor ?? TekColors().white;

    if (widget.column.key == TekDataTableReorderableAdditionColumn.checkbox.toString()) {
      return SizedBox(
        width: widget.column.width,
        child: TekCheckBoxColumnReorderable(
          controller: widget.controller,
          onSelectCheckBox: widget.checkBoxOption.onSelectCheckBox,
        ),
      );
    }
    if (widget.column.key == TekDataTableReorderableAdditionColumn.numbered.toString()) {
      return SizedBox(
        width: widget.column.width,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'No.',
            textAlign: TextAlign.center,
            style: TekTextStyles().body.copyWith(
              fontWeight: FontWeight.bold,
              color: headerTextColors,
            ),
          ),
        ),
      );
    }
    final double? widthOfRowItem = widget.controller.mapKeyToWidthOfEachColumnContent[widget.column.key];
    return Stack(
      children: <Widget>[
        widget.column.customizeTitleWidget != null
            ? widget.column.customizeTitleWidget!(
                context,
                widget.column.key,
                widget.column.name,
                widthOfRowItem,
                widget.column.showOnScreens,
              )
            : Container(
                alignment: widget.headerOption.alignment ?? Alignment.center,
                padding: widget.headerOption.padding ??
                    EdgeInsets.symmetric(horizontal: TekSpacings().p8),
                child: Text(
                  widget.column.name ?? '',
                  textAlign: TextAlign.center,
                  style: TekTextStyles().body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: headerTextColors,
                  ),
                ),
              ),
        if (widget.column.isShowSort || widget.column.isShowFilter)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              children: <Widget>[
                if (widget.column.isShowSort) _sortWidget(),
                if (widget.column.isShowFilter) _filterWidget(context),
              ],
            ),
          ),
      ],
    );
  }

  Widget _sortWidget() {
    return TekButtonGD(
      onPressed: _handleChangeSortType,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: TekSpacings().p8),
            child: Icon(
              Icons.arrow_drop_up_rounded,
              size: TekIconSizes().s24,
              color: (widget.sortType.value == TekDataTableReorderableSortType.asc &&
                      widget.sortType.key == widget.column.key)
                  ? TekColors().white
                  : TekColors().grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: TekSpacings().p8),
            child: Icon(
              Icons.arrow_drop_down_rounded,
              size: TekIconSizes().s24,
              color: (widget.sortType.value == TekDataTableReorderableSortType.desc &&
                      widget.sortType.key == widget.column.key)
                  ? TekColors().white
                  : TekColors().grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _filterWidget(BuildContext context) {
    return MenuAnchor(
      crossAxisUnconstrained: false,
      controller: _menuController,
      alignmentOffset: widget.column.customizeFilter!.offset ?? const Offset(0, 10),
      style: MenuStyle(
        fixedSize: MaterialStateProperty.all(
          Size(
            widget.column.customizeFilter!.widthPopup,
            widget.column.customizeFilter!.heightPopup,
          ),
        ),
        visualDensity: VisualDensity.comfortable,
      ),
      menuChildren: [
        widget.column.customizeFilter!.child(
          context,
          widget.column.key,
          widget.column.name,
          enableFilter,
          isShowMenu,
          _setEnableFilter,
          _handleChangeShowMenu,
          _handleFilterData,
        ),
      ],
      builder: (context, controller, child) {
        return Padding(
          padding: EdgeInsets.only(right: TekSpacings().p8),
          child: TekButtonGD(
            onPressed: () => _handleChangeShowMenu(!_menuController.isOpen),
            child: Icon(
              Icons.filter_list_rounded,
              size: TekIconSizes().s24,
              color: enableFilter ? TekColors().white : TekColors().grey,
            ),
          ),
        );
      },
    );
  }
}
