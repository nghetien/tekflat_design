part of '../data_table.dart';

class TekDataTableHeaderItemWidget<T> extends StatefulWidget {
  const TekDataTableHeaderItemWidget({
    Key? key,
    required this.index,
    required this.lengthOfColumn,
    this.fixedColumn = TekFixedColumn.none,
    required this.controller,
    required this.column,
    required this.headerOption,
    required this.checkBoxOption,
    required this.sortType,
    required this.onSelectSortType,
  }) : super(key: key);

  final int index;
  final int lengthOfColumn;
  final TekFixedColumn fixedColumn;
  final TekDataTableController<T> controller;
  final DataTableColumn<T> column;
  final TekDataTableHeaderOption headerOption;
  final TekDataTableCheckBoxOption<T> checkBoxOption;
  final MapEntry<String, TekDataTableSortType> sortType;
  final ValueChanged<MapEntry<String, TekDataTableSortType>> onSelectSortType;

  @override
  State<TekDataTableHeaderItemWidget<T>> createState() => _TekDataTableHeaderItemWidgetState<T>();
}

class _TekDataTableHeaderItemWidgetState<T> extends State<TekDataTableHeaderItemWidget<T>> {
  final MenuController _menuController = MenuController();
  bool _enableFilter = false;
  bool _isShowMenu = false;

  bool get enableFilter => _enableFilter;

  bool get isShowMenu => _isShowMenu;

  void _setEnableFilter(bool value) => setState(() => _enableFilter = value);

  void _setIsShowMenu(bool value) => _isShowMenu = value;

  void _handleChangeSortType() {
    late TekDataTableSortType type;
    if (widget.column.key != widget.sortType.key) {
      type = TekDataTableSortType.asc;
      widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableSortType.asc));
    } else {
      switch (widget.sortType.value) {
        case TekDataTableSortType.none:
          type = TekDataTableSortType.asc;
          widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableSortType.asc));
          break;
        case TekDataTableSortType.asc:
          type = TekDataTableSortType.desc;
          widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableSortType.desc));
          break;
        case TekDataTableSortType.desc:
          type = TekDataTableSortType.none;
          widget.onSelectSortType(MapEntry(widget.column.key, TekDataTableSortType.none));
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
      width: widget.fixedColumn == TekFixedColumn.none
          ? widget.controller.mapKeyToWidthOfEachColumnContent[widget.column.key]
          : widget.column.width,
      height:
          widget.headerOption.heightOfHeaderItem ?? TekDataTableHeaderWidget.defaultHeightHeader,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: widget.index < widget.lengthOfColumn - 1
                ? BorderSide(
                    color: widget.headerOption.splitColor ?? TekColors().greyOpacity04,
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

    if (widget.column.key == TekDataTableAdditionColumn.checkbox.toString()) {
      return SizedBox(
        width: widget.column.width,
        child: TekCheckBoxColumn(
          controller: widget.controller,
          onSelectCheckBox: widget.checkBoxOption.onSelectCheckBox,
        ),
      );
    }
    if (widget.column.key == TekDataTableAdditionColumn.numbered.toString()) {
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
    final double? widthOfRowItem = widget.fixedColumn != TekFixedColumn.none
        ? widget.column.width
        : widget.controller.mapKeyToWidthOfEachColumnContent[widget.column.key];
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
            : Builder(builder: (context) {
                final title = widget.column.name ?? '',
                    titleAlignment = widget.column.defaultTitleAlignment ??
                        widget.headerOption.alignment ??
                        Alignment.center,
                    titlePadding = widget.headerOption.padding ??
                        EdgeInsets.symmetric(horizontal: TekSpacings().p8),
                    titleColor = widget.column.defaultTitleColor ??
                        widget.headerOption.headerTextColor ??
                        headerTextColors;

                return Container(
                  alignment: titleAlignment,
                  padding: titlePadding,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TekTextStyles().body.copyWith(
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                  ),
                );
              }),
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
              color: (widget.sortType.value == TekDataTableSortType.asc &&
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
              color: (widget.sortType.value == TekDataTableSortType.desc &&
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
