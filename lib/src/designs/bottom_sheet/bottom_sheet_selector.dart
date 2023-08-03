part of 'bottom_sheet.dart';

class TekBottomSheetSelectorModel<T> {
  TekBottomSheetSelectorModel({
    required this.keyValue,
    required this.value,
    this.label,
    this.child,
  })  : assert(
          keyValue.isNotEmpty,
          'keyValue must not be empty',
        ),
        assert(
          label != null || child != null,
          'label or child must not be null',
        );

  final String keyValue;
  final T value;
  final String? label;
  final Widget Function(T, String)? child;
}

enum TekBottomSheetSelectorType {
  single,
  multiple,
}

class TekBottomSheetSelectorWidget<T> extends StatefulWidget {
  const TekBottomSheetSelectorWidget({
    super.key,
    this.title,
    this.type = TekBottomSheetSelectorType.single,
    this.initMenuChildren,
    this.onLoadingMenuChildren,
    this.onRefreshMenuChildren,
    this.onSearchMenuChildren,
    this.onSelected,
    this.initSelected = const [],
    this.initSearchText,
    this.hintText,
    required this.constraints,
  });

  final String? title;
  final TekBottomSheetSelectorType type;
  final List<String> initSelected;
  final Future<List<TekBottomSheetSelectorModel<T>>?> Function()? initMenuChildren;
  final Future<List<TekBottomSheetSelectorModel<T>>?> Function()? onLoadingMenuChildren;
  final Future<List<TekBottomSheetSelectorModel<T>>?> Function()? onRefreshMenuChildren;
  final Future<List<TekBottomSheetSelectorModel<T>>?> Function(
    String?,
    List<T>,
  )? onSearchMenuChildren;
  final Function(
    T,
    List<T>,
  )? onSelected;
  final String? initSearchText;
  final String? hintText;
  final BoxConstraints constraints;

  @override
  State<TekBottomSheetSelectorWidget<T>> createState() => _TekBottomSheetSelectorWidgetState<T>();
}

class _TekBottomSheetSelectorWidgetState<T> extends State<TekBottomSheetSelectorWidget<T>> {
  late final TextEditingController _searchController;
  final TekLoadingController _loadingController = TekLoadingController();
  final RefreshController _refreshController = RefreshController();

  // init load widget
  bool _isInitLoad = false;

  void _setIsInitLoad(bool value) => _isInitLoad = value;

  // TekBottomSheetSelectorType.single
  TekBottomSheetSelectorModel<T>? _currentSelected;

  void _setCurrentSelected(TekBottomSheetSelectorModel<T>? value) => _currentSelected = value;

  // TekBottomSheetSelectorType.multiple
  List<TekBottomSheetSelectorModel<T>> _listCurrentSelected = [];

  void _setListCurrentSelected(List<TekBottomSheetSelectorModel<T>> value) =>
      setState(() => _listCurrentSelected = value);

  late Map<String, TekBottomSheetSelectorModel<T>> _mapKeyValueToCurrentSelected;

  // List item
  List<TekBottomSheetSelectorModel<T>> _menuChildren = [];

  void _setMenuChildren(List<TekBottomSheetSelectorModel<T>> value) =>
      setState(() => _menuChildren = value);

  void _addAllMenuChildren(List<TekBottomSheetSelectorModel<T>> value) {
    _menuChildren.addAll(value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initSearchText);
    if (widget.initMenuChildren != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _loadingController.openAndDismissLoading(
            () async {
              final result = await widget.initMenuChildren!();
              if (result == null || result.isEmpty) return;
              _menuChildren = result;
              if (widget.type == TekBottomSheetSelectorType.single) {
                if (widget.initSelected.isNotEmpty) {
                  _currentSelected = _menuChildren.firstWhereOrNull(
                    (e) => e.keyValue == widget.initSelected.first,
                  );
                }
              } else {
                _listCurrentSelected = _menuChildren
                    .where(
                      (e) => widget.initSelected.contains(e.keyValue),
                    )
                    .toList();
                _mapKeyValueToCurrentSelected = Map.fromEntries(
                  _listCurrentSelected.map(
                    (e) => MapEntry(e.keyValue, e),
                  ),
                );
              }
              _setIsInitLoad(true);
              setState(() {});
            },
          );
        },
      );
    }
  }

  void _onSubmitted(String? value) {
    if (value == null || value.isEmpty) {
      return;
    }
    _loadingController.openAndDismissLoading(
      () async {
        final result = await widget.onSearchMenuChildren?.call(
          value,
          _menuChildren.map((e) => e.value).toList(),
        );
        _setMenuChildren(result ?? []);
      },
    );
  }

  void _onSelected(TekBottomSheetSelectorModel<T> item) {
    _setCurrentSelected(item);
    if (widget.type == TekBottomSheetSelectorType.single) {
      _onBack();
      widget.onSelected?.call(_currentSelected!.value, [_currentSelected!.value]);
    } else {
      if (_mapKeyValueToCurrentSelected.containsKey(item.keyValue)) {
        _mapKeyValueToCurrentSelected.remove(item.keyValue);
      } else {
        _mapKeyValueToCurrentSelected[item.keyValue] = item;
      }
      _setListCurrentSelected(_mapKeyValueToCurrentSelected.values.toList());
      widget.onSelected?.call(
        _currentSelected!.value,
        _listCurrentSelected.map((e) => e.value).toList(),
      );
    }
  }

  void _onBack() {
    context.popNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(TekSpacings().mainSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TekTypography(
                    text: widget.title ?? '',
                    type: TekTypographyType.level5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TekButtonInkwell(
                  onPressed: _onBack,
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          const TekDivider(),
          if (widget.onSearchMenuChildren != null)
            Container(
              padding: EdgeInsets.all(TekSpacings().mainSpacing),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: TekColors.greyOpacity01,
                    width: TekBorders.med,
                  ),
                ),
              ),
              child: TekInput(
                controller: _searchController,
                hintText: widget.hintText,
                onSubmitted: _onSubmitted,
                prefixIcon: const Icon(Icons.search),
                textInputAction: TextInputAction.search,
              ),
            ),
          Container(
            constraints: widget.constraints,
            child: _loadingController.initLoading(
              context,
              _contentWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewItemWidget(int index, TekBottomSheetSelectorModel<T> item) {
    final child = item.child?.call(item.value, item.keyValue) ?? Text(item.label ?? '');
    return TekButtonInkwell(
      onPressed: () => _onSelected(item),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: TekColors.greyOpacity01,
              width: TekBorders.med,
            ),
          ),
        ),
        child: widget.type == TekBottomSheetSelectorType.single
            ? Container(
                color:
                    _currentSelected?.keyValue == item.keyValue ? TekColors.greenOpacity01 : null,
                padding: EdgeInsets.all(TekSpacings().mainSpacing),
                child: child,
              )
            : Container(
                color: _mapKeyValueToCurrentSelected.containsKey(item.keyValue)
                    ? TekColors().primaryOpacity01
                    : null,
                padding: EdgeInsets.all(TekSpacings().mainSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: child),
                    if (_mapKeyValueToCurrentSelected.containsKey(item.keyValue))
                      Icon(
                        Icons.check_rounded,
                        color: TekColors().primary,
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _listViewWidget() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: _menuChildren.length,
      itemBuilder: (builderContext, index) {
        final item = _menuChildren[index];
        return _viewItemWidget(index, item);
      },
    );
  }

  Widget _contentWidget() {
    if (widget.onLoadingMenuChildren == null && widget.onRefreshMenuChildren == null) {
      return _listViewWidget();
    }
    return TekRefresher(
      controller: _refreshController,
      onRefresh: () {
        _searchController.clear();
        widget.onRefreshMenuChildren?.call().then(
          (value) {
            _refreshController.refreshCompleted();
            if (value == null || value.isEmpty) return;
            _setMenuChildren(value);
          },
        );
      },
      onLoading: () {
        widget.onLoadingMenuChildren?.call().then(
          (value) {
            _refreshController.loadComplete();
            if (value == null || value.isEmpty) return;
            _addAllMenuChildren(value);
          },
        );
      },
      child: _menuChildren.isNotEmpty
          ? _listViewWidget()
          : _isInitLoad
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.not_interested_rounded,
                        size: TekIconSizes().s24,
                        color: TekColors.grey,
                      ),
                      TekVSpace.mainSpace,
                      const Text('No data'),
                    ],
                  ),
                )
              : const SizedBox(),
    );
  }
}
