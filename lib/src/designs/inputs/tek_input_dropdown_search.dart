part of 'inputs.dart';

class TekInputDropdownSearch<T> extends StatefulWidget {
  const TekInputDropdownSearch({
    Key? key,
    this.name,
    this.filterOption,
    this.menuChildren = const [],
    this.onSelected,
    this.tagsAbleScroll = false,
    this.closeDropdownAfterSelect = true,
    this.searchController,
    this.hintTextSearch = 'Search',
    this.prefixIconSearch,
    this.backgroundColorSelected,
    this.iconSelected,
    this.offset,
    this.maxHeightPopup,
    this.minHeightPopup,
    this.maxWidthPopup,
    this.minWidthPopup,
    this.size = TekInputSize.medium,
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
    this.onSubmitted,
    this.isDense,
    this.filled,
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
    this.maxLinesDropdownItem,
  }) : super(key: key);

  final String? name;
  final List<TekInputDropdownItemModel<T>> Function(String, List<TekInputDropdownItemModel<T>>)?
      filterOption;
  final List<TekInputDropdownItemModel<T>> menuChildren;
  final Function(TekInputDropdownItemModel<T>, List<TekInputDropdownItemModel<T>>)? onSelected;
  final bool tagsAbleScroll;
  final bool closeDropdownAfterSelect;
  final TextEditingController? searchController;
  final String hintTextSearch;
  final Widget? prefixIconSearch;
  final Color? backgroundColorSelected;
  final Widget? iconSelected;
  final Offset? offset;
  final double? maxHeightPopup;
  final double? minHeightPopup;
  final double? maxWidthPopup;
  final double? minWidthPopup;
  final TekInputSize size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(bool)? onFocusChange;
  final String? initialValue;
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
  final ValueTransformer<List<TekInputDropdownItemModel<T>>?>? valueTransformer;
  final ValueChanged<String?>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter? onSaved;
  final ValueChanged<String?>? onSubmitted;
  final bool? isDense;
  final bool? filled;
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
  final int? maxLinesDropdownItem;

  @override
  State<TekInputDropdownSearch<T>> createState() => _TekInputDropdownSearchState<T>();
}

class _TekInputDropdownSearchState<T> extends State<TekInputDropdownSearch<T>>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormBuilderFieldState> _key = GlobalKey<FormBuilderFieldState>();
  final MenuController _menuController = MenuController();
  late final FocusNode _focusNode;
  late final TextEditingController _searchController;
  final FocusNode _searchFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late List<TekInputDropdownItemModel<T>> _menuChildren;
  late List<TekInputDropdownItemModel<T>> _menuChildrenSelected;
  late final ScrollController _scrollController;

  void _onFocusChange() {
    FocusManager.instance.primaryFocus?.unfocus();
    _menuController.open();
    if (!_searchFocusNode.hasPrimaryFocus) _searchFocusNode.requestFocus();
    widget.onFocusChange?.call(_focusNode.hasFocus);
  }

  void _listenOnChangeInput() {
    if (widget.filterOption == null) return;
    if (_searchController.text.isNotEmpty) {
      setState(
        () => _menuChildren = widget.filterOption!(_searchController.text, widget.menuChildren),
      );
    } else {
      setState(() => _menuChildren = widget.menuChildren);
    }
  }

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
    _menuChildren = widget.menuChildren;
    _menuChildrenSelected = [];
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _searchController = widget.searchController ?? TextEditingController();
    _searchController.addListener(_listenOnChangeInput);
    if (widget.tagsAbleScroll) _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _searchController.removeListener(_listenOnChangeInput);
    super.dispose();
  }

  void _setPopupIsOpen(bool value) {
    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handleSelectItem(TekInputDropdownItemModel<T> item) {
    if (_menuChildrenSelected.contains(item)) {
      _menuChildrenSelected.remove(item);
    } else {
      _menuChildrenSelected.add(item);
    }
    if (_menuChildrenSelected.isEmpty) {
      _key.currentState!.setValue(null);
    } else {
      _key.currentState!.setValue(
        _menuChildrenSelected.map((e) => e.keyValue ?? '').toList().join(','),
      );
    }
    widget.onSelected?.call(
      item,
      _menuChildrenSelected,
    );
    if (widget.closeDropdownAfterSelect) _menuController.close();
    setState(() {});
  }

  void _handleRemoveItem(TekInputDropdownItemModel<T> item) {
    _menuChildrenSelected.remove(item);
    if (_menuChildrenSelected.isEmpty) {
      _key.currentState!.setValue(null);
    } else {
      _key.currentState!.setValue(
        _menuChildrenSelected.map((e) => e.keyValue ?? '').toList().join(','),
      );
    }
    widget.onSelected?.call(
      item,
      _menuChildrenSelected,
    );
    setState(() {});
  }

  TekButtonSize get _getSizeDropdownItem {
    if (widget.size == TekInputSize.medium) {
      return TekButtonSize.medium;
    }
    if (widget.size == TekInputSize.large) {
      return TekButtonSize.large;
    }
    if (widget.size == TekInputSize.extraLarge) {
      return TekButtonSize.extraLarge;
    }
    return TekButtonSize.medium;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = widget.width ?? constraints.maxWidth;
        return MenuAnchor(
          onOpen: () => _setPopupIsOpen(true),
          onClose: () => _setPopupIsOpen(false),
          crossAxisUnconstrained: false,
          controller: _menuController,
          alignmentOffset: widget.offset ?? const Offset(0, 10),
          style: MenuStyle(
            minimumSize: MaterialStateProperty.all(
              Size(
                widget.minWidthPopup ?? width,
                widget.minHeightPopup ??
                    _menuChildren.length * _getSizeDropdownItem.height + 24 + widget.size.height,
              ),
            ),
            maximumSize: MaterialStateProperty.all(
              Size(
                widget.maxWidthPopup ?? width,
                widget.maxHeightPopup ??
                    _menuChildren.length * _getSizeDropdownItem.height + 24 + widget.size.height,
              ),
            ),
            visualDensity: VisualDensity.comfortable,
          ),
          menuChildren: _generateMenuChildren(),
          builder: (context, controller, child) {
            return TekInput(
              keyFormState: _key,
              controller: widget.controller,
              name: widget.name,
              size: widget.size,
              width: widget.width,
              focusNode: _focusNode,
              initialValue: widget.initialValue,
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
                return widget.valueTransformer?.call(_menuChildrenSelected);
              },
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              onEditingComplete: widget.onEditingComplete,
              onSaved: widget.onSaved,
              onSubmitted: widget.onSubmitted,
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
              ablePrefixIconConstraints: false,
              readOnly: true,
            );
          },
        );
      },
    );
  }

  List<Widget> _generateMenuChildren() {
    return [
      Padding(
        padding: EdgeInsets.all(TekSpacings().p8).copyWith(top: TekSpacings().p4),
        child: TekInput(
          focusNode: _searchFocusNode,
          controller: _searchController,
          size: widget.size,
          prefixIcon: widget.prefixIconSearch ?? const Icon(Icons.search),
          hintText: widget.hintTextSearch,
        ),
      ),
      ..._menuChildren.map(
        (item) {
          final bool isSelected = _menuChildrenSelected.contains(item);
          return TekButton(
            width: double.infinity,
            size: _getSizeDropdownItem,
            onPressed: () => _handleSelectItem(item),
            alignment: Alignment.centerLeft,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            background: isSelected
                ? widget.backgroundColorSelected ?? TekColors.greenOpacity01
                : Colors.transparent,
            mainAxisAlignment: MainAxisAlignment.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: item.child != null
                      ? item.child!(item.value, item.label)
                      : Text(
                          item.label,
                          maxLines: widget.maxLinesDropdownItem,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                if (isSelected)
                  widget.iconSelected ??
                      const Icon(
                        Icons.check,
                        color: TekColors.green,
                      )
              ],
            ),
          );
        },
      ).toList(),
    ];
  }

  Widget? _getPrefixIcon() {
    if(_menuChildrenSelected.isEmpty) return null;
    final Widget prefixIcon = Padding(
      padding: EdgeInsets.all(TekSpacings().p8),
      child: Wrap(
        runSpacing: TekSpacings().p8,
        spacing: TekSpacings().p8,
        children: _menuChildrenSelected.map(
          (item) {
            return TekDynamicTag(
              textContent: item.label,
              whenClose: () => _handleRemoveItem(item),
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
}
