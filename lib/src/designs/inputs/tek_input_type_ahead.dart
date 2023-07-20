part of 'inputs.dart';

class TekInputTypeAheadDropdownItemModel<T> extends TekInputDropdownItemModel<T> {
  const TekInputTypeAheadDropdownItemModel({
    required super.keyValue,
    required super.value,
    required super.label,
    super.child,
  });
}

class TekInputTypeAhead<T> extends StatefulWidget {
  const TekInputTypeAhead({
    Key? key,
    this.name,
    this.isSelectOne = true,
    required this.onSelected,
    required this.initMenuChildren,
    required this.onLoadingMenuChildren,
    required this.onRefreshMenuChildren,
    this.onSearchMenuChildren,
    this.reloadMenuChildrenEachOpen = false,
    this.closeDropdownAfterSelect = true,
    this.searchController,
    this.tagsAbleScroll = false,
    this.hintTextSearch = 'Search',
    this.prefixIconSearch,
    this.backgroundColorSelected,
    this.iconSelected,
    this.offset,
    this.maxHeightPopup,
    required this.minHeightPopup,
    this.maxWidthPopup,
    this.minWidthPopup,
    this.size,
    this.width,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onFocusChange,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textInputAction,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.obscureText = false,
    this.scrollPadding,
    this.cursorColor,
    this.autoValidateMode,
    this.validator,
    this.inputFormatters,
    this.valueTransformer,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSaved,
    this.isDense,
    this.filled,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.hoverColor,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabelBehavior,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.errorMaxLines,
    this.errorStyle,
  }) : super(key: key);

  final String? name;
  final bool isSelectOne;
  final Function(TekInputTypeAheadDropdownItemModel<T>, List<TekInputTypeAheadDropdownItemModel<T>>)
      onSelected;
  final Future<List<TekInputTypeAheadDropdownItemModel<T>>> Function() initMenuChildren;
  final Future<List<TekInputTypeAheadDropdownItemModel<T>>> Function() onLoadingMenuChildren;
  final Future<List<TekInputTypeAheadDropdownItemModel<T>>> Function() onRefreshMenuChildren;
  final Future<List<TekInputTypeAheadDropdownItemModel<T>>> Function(String)? onSearchMenuChildren;
  final bool reloadMenuChildrenEachOpen;
  final bool closeDropdownAfterSelect;
  final bool tagsAbleScroll;
  final TextEditingController? searchController;
  final String hintTextSearch;
  final Widget? prefixIconSearch;
  final Color? backgroundColorSelected;
  final Widget? iconSelected;
  final Offset? offset;
  final double? maxHeightPopup;
  final double minHeightPopup;
  final double? maxWidthPopup;
  final double? minWidthPopup;
  final TekInputSize? size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(bool)? onFocusChange;
  final List<TekInputTypeAheadDropdownItemModel<T>>? initialValue;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool obscureText;
  final EdgeInsets? scrollPadding;
  final Color? cursorColor;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueTransformer<List<TekInputTypeAheadDropdownItemModel<T>>?>? valueTransformer;
  final ValueChanged<String?>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter? onSaved;
  final bool? isDense;
  final bool? filled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final Color? hoverColor;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final int? errorMaxLines;
  final TextStyle? errorStyle;

  @override
  State<TekInputTypeAhead<T>> createState() => TekInputTypeAheadState<T>();
}

class TekInputTypeAheadState<T> extends State<TekInputTypeAhead<T>>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormBuilderFieldState> _key = GlobalKey<FormBuilderFieldState>();
  final MenuController _menuController = MenuController();
  final FocusNode _searchFocusNode = FocusNode();
  final TekLoadingController _loading = TekLoadingController();
  final RefreshController _refreshController = RefreshController();
  late final FocusNode _focusNode;
  late final TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  List<TekInputTypeAheadDropdownItemModel<T>> _menuChildren = [];
  late double _widthPopupMenu;
  final TekDebounce _debounce = TekDebounce(milliseconds: 500);
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;

  MapEntry<String, TekInputTypeAheadDropdownItemModel<T>>? _selectedItem;
  final Map<String, TekInputTypeAheadDropdownItemModel<T>> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _searchController = widget.searchController ?? TextEditingController();
    if (widget.tagsAbleScroll) _scrollController = ScrollController();
    _textEditingController = widget.controller ?? TextEditingController();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      if (widget.isSelectOne) {
        _textEditingController.text = widget.initialValue!.first.label;
        _selectedItem = MapEntry(widget.initialValue!.first.keyValue!, widget.initialValue!.first);
      } else {
        _selectedItems
            .addAll(Map.fromEntries(widget.initialValue!.map((e) => MapEntry(e.keyValue!, e))));
      }
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.initMenuChildren().then((value) => setState(() => _menuChildren = value)),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void resetCurrentData(List<String> values) {
    if (values.isEmpty) {
      _selectedItem = null;
      _selectedItems.clear();
      _textEditingController.clear();
      return;
    }
    if (widget.isSelectOne) {
      final find = _menuChildren.firstWhereOrNull((element) => element.keyValue == values.first);
      if (find != null) {
        _selectedItem = MapEntry(values.first, find);
        _textEditingController.text = _selectedItem!.value.label;
      }
    } else {
      try {
        _selectedItems.clear();
        _selectedItems.addAll(Map.fromEntries(_menuChildren
            .where((element) => values.contains(element.keyValue))
            .map((e) => MapEntry(e.keyValue!, e))));
        _textEditingController.text = _selectedItems.values.map((e) => e.label).join(', ');
      } catch (e) {
        TekLogger.errorLog('TekInputTypeAhead resetCurrentData $e');
      }
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
      _menuController.open();
      if (!_searchFocusNode.hasPrimaryFocus) _searchFocusNode.requestFocus();
    }
    widget.onFocusChange?.call(_focusNode.hasFocus);
  }

  void _listenOnChangeInput() => _debounce.run(
        () {
          if (widget.onSearchMenuChildren != null) _loading.show();
          widget.onSearchMenuChildren?.call(_searchController.text).then(
            (value) {
              setState(() => _menuChildren = value);
              _loading.dismiss();
            },
          );
        },
      );

  void _setPopupIsOpen(bool value) {
    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  bool _isSelected(int index) => widget.isSelectOne
      ? _selectedItem?.key == _menuChildren[index].keyValue
      : _selectedItems[_menuChildren[index].keyValue] != null;

  void _handleSelectItem(int index) {
    final TekInputTypeAheadDropdownItemModel<T> item = _menuChildren[index];
    if (widget.isSelectOne) {
      if (_selectedItem?.key != _menuChildren[index].keyValue) {
        _textEditingController.text = item.label;
        _selectedItem = MapEntry(
          _menuChildren[index].keyValue!,
          _menuChildren[index],
        );
        _key.currentState!.setValue(item.label);
      } else {
        _selectedItem = null;
        _textEditingController.clear();
        _key.currentState!.setValue(null);
      }
    } else {
      if (_selectedItems[_menuChildren[index].keyValue] != null) {
        _selectedItems.remove(_menuChildren[index].keyValue);
      } else {
        _selectedItems[_menuChildren[index].keyValue!] = _menuChildren[index];
      }
      if (_selectedItems.isEmpty) {
        _key.currentState!.setValue(null);
      } else {
        _key.currentState!.setValue(
          _selectedItems.values.map<String>((value) => value.keyValue ?? '').toList(),
        );
      }
    }
    widget.onSelected.call(
      _menuChildren[index],
      widget.isSelectOne ? [] : _selectedItems.values.toList(),
    );
    if (widget.closeDropdownAfterSelect) _menuController.close();
    setState(() {});
  }

  void _handleRemoveItem(String key) {
    widget.onSelected.call(
      _selectedItems[key]!,
      _selectedItems.values.toList(),
    );
    if (_selectedItems.isEmpty) {
      _key.currentState!.setValue(null);
    } else {
      _key.currentState!.setValue(
        _selectedItems.values.map<String>((value) => value.keyValue ?? '').toList(),
      );
    }
    _selectedItems.remove(key);
    setState(() {});
  }

  TekButtonSize get _getSizeDropdownItem {
    if (widget.size == TekInputSize.medium) {
      return TekButtonSize.medium;
    }
    if (widget.size == TekInputSize.large) {
      return TekButtonSize.large;
    }
    return TekButtonSize.medium;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        _widthPopupMenu = widget.width ?? constraints.maxWidth;
        return MenuAnchor(
          onOpen: () {
            _setPopupIsOpen(true);
            if (widget.reloadMenuChildrenEachOpen) {
              _loading.show();
              widget.initMenuChildren().then(
                (value) {
                  _loading.dismiss();
                  setState(() => _menuChildren = value);
                },
              );
            }
          },
          onClose: () => _setPopupIsOpen(false),
          crossAxisUnconstrained: false,
          controller: _menuController,
          alignmentOffset: widget.offset ?? const Offset(0, 10),
          style: const MenuStyle(visualDensity: VisualDensity.comfortable),
          menuChildren: _generateMenuChildren(),
          builder: (context, controller, child) {
            return TekInput(
              keyFormState: _key,
              name: widget.name,
              size: widget.size,
              width: widget.width,
              controller: _textEditingController,
              focusNode: _focusNode,
              textAlign: widget.textAlign,
              textAlignVertical: widget.textAlignVertical,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              cursorColor: widget.cursorColor,
              autoValidateMode: widget.autoValidateMode,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
              valueTransformer: (value) {
                if (widget.isSelectOne) {
                  if (_selectedItem == null) return widget.valueTransformer?.call(null);
                  return widget.valueTransformer?.call([_selectedItem!.value]);
                } else {
                  if (_selectedItems.isEmpty) return widget.valueTransformer?.call(null);
                  return widget.valueTransformer?.call(_selectedItems.values.toList());
                }
              },
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              onEditingComplete: widget.onEditingComplete,
              onSaved: widget.onSaved,
              isDense: widget.isDense,
              filled: widget.filled,
              prefixIcon: _getPrefixIcon(),
              suffixIcon: _getSuffixIcon(),
              contentPadding: widget.contentPadding,
              focusedBorder: widget.focusedBorder,
              enabledBorder: widget.enabledBorder,
              disabledBorder: widget.disabledBorder,
              errorBorder: widget.errorBorder,
              focusedErrorBorder: widget.focusedErrorBorder,
              fillColor: widget.fillColor,
              hoverColor: widget.hoverColor,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              floatingLabelStyle: widget.floatingLabelStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              errorText: widget.errorText,
              errorMaxLines: widget.errorMaxLines,
              errorStyle: widget.errorStyle,
            );
          },
        );
      },
    );
  }

  BoxConstraints _getBoxConstraints() {
    final double defaultHeight = 100.scaleSize;
    double minHeight = _menuChildren.isEmpty ? defaultHeight : widget.minHeightPopup;
    double? maxHeight = widget.maxHeightPopup;
    double minWidth = widget.minWidthPopup ?? _widthPopupMenu;
    double? maxWidth = widget.maxWidthPopup;
    if (maxHeight != null && maxHeight < minHeight) minHeight = maxHeight;
    maxHeight ??= minHeight;
    if (maxWidth != null && maxWidth < minWidth) minWidth = maxWidth;
    maxWidth ??= minWidth;
    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  List<Widget> _generateMenuChildren() {
    return [
      if (widget.onSearchMenuChildren != null)
        Padding(
          padding: EdgeInsets.all(TekSpacings().p8).copyWith(top: TekSpacings().p4),
          child: TekInput(
            focusNode: _searchFocusNode,
            controller: _searchController,
            size: TekInputSize.medium,
            prefixIcon: widget.prefixIconSearch ?? const Icon(Icons.search),
            hintText: widget.hintTextSearch,
            onChanged: (_) => _listenOnChangeInput(),
          ),
        ),
      Container(
        constraints: _getBoxConstraints(),
        child: _loading.initLoading(
          context,
          ScrollConfiguration(
            behavior: TekScrollBehavior(),
            child: TekRefresher(
              controller: _refreshController,
              onRefresh: () {
                _searchController.clear();
                widget.onRefreshMenuChildren().then(
                  (value) {
                    _refreshController.refreshCompleted();
                    setState(() => _menuChildren = value);
                  },
                );
              },
              onLoading: () => widget.onLoadingMenuChildren().then(
                (value) {
                  _refreshController.loadComplete();
                  setState(() => _menuChildren.addAll(value));
                },
              ),
              child: _menuChildren.isNotEmpty
                  ? ListView.separated(
                      controller: ScrollController(),
                      itemCount: _menuChildren.length,
                      separatorBuilder: (BuildContext context, int index) => TekVSpace.p4,
                      itemBuilder: (context, index) {
                        if (_menuChildren.isEmpty) return const SizedBox.shrink();
                        final TekInputTypeAheadDropdownItemModel<T> item = _menuChildren[index];
                        return TekButton(
                          width: double.infinity,
                          padding: EdgeInsets.all(TekSpacings().p8).copyWith(
                            top: TekSpacings().p4,
                            bottom: TekSpacings().p4,
                          ),
                          size: _getSizeDropdownItem,
                          onPressed: () => _handleSelectItem(index),
                          alignment: Alignment.centerLeft,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          background: Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              item.child != null
                                  ? Expanded(child: item.child!(item.value, item.label))
                                  : Flexible(
                                      child: Text(item.label),
                                    ),
                              if (_isSelected(index))
                                widget.iconSelected ??
                                    const Icon(
                                      Icons.check,
                                      color: TekColors.green,
                                    )
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
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
                    ),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _getSuffixIcon() {
    return InkWell(
      onTap: () {
        if (_menuController.isOpen) {
          _menuController.close();
        } else {
          _menuController.open();
        }
      },
      child: RotationTransition(
        turns: _rotateAnimation,
        child: Icon(
          Icons.expand_more_rounded,
          size: TekIconSizes().s24,
        ),
      ),
    );
  }

  Widget? _getPrefixIcon() {
    if (widget.isSelectOne) return widget.prefixIcon;
    if (_selectedItems.isEmpty) return null;
    final Widget prefixIcon = Padding(
      padding: EdgeInsets.all(TekSpacings().p8),
      child: Wrap(
        runSpacing: TekSpacings().p8,
        spacing: TekSpacings().p8,
        children: _selectedItems.keys.map(
          (key) {
            return TekDynamicTag(
              textContent: _selectedItems[key]?.label,
              whenClose: () => _handleRemoveItem(key),
            );
          },
        ).toList(),
      ),
    );
    if (widget.tagsAbleScroll) {
      return TekWrapScrollHorizontal(
        controller: _scrollController,
        child: prefixIcon,
      );
    }
    return prefixIcon;
  }
}
