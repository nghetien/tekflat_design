part of 'inputs.dart';

class TekInputDropdownItemModel<T> {
  TekInputDropdownItemModel({
    required this.value,
    required this.keyValue,
    required this.label,
    this.child,
  }) : assert(
          keyValue.isNotEmpty,
          'keyValue must not be empty',
        );

  final T value;
  final String keyValue;
  final String label;
  final Widget Function(T, String)? child;
}

enum TekInputDropdownType {
  single,
  multi;

  bool get isSingle => this == TekInputDropdownType.single;

  bool get isMulti => this == TekInputDropdownType.multi;
}

class TekInputDropdown<T> extends StatefulWidget {
  const TekInputDropdown({
    Key? key,

    /// MenuDate
    this.menuChildren = const [],

    /// Type
    this.type = TekInputDropdownType.single,
    this.closeAfterSelect = false,

    /// Value & Action
    this.valueSingle,
    this.valueMultiple,
    this.onChangedSingle,
    this.onChangedMultiple,

    /// Text Field
    this.size = TekInputSize.medium,
    this.width,
    this.controller,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textInputAction,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.obscureText = false,
    this.cursorColor,
    this.inputFormatters,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onSubmitted,
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
    this.readOnly = false,

    /// Dropdown
    this.offset,
    this.maxHeightPopup,
    this.maxWidthPopup,
    this.minHeightPopup,
    this.minWidthPopup,
    this.tagsAbleScroll = false,
    this.ableClearValue = true,
    this.dropdownItemMaxLines = 1,
    this.dropdownItemAlignment,
    this.dropdownItemMainAxisAlignment,
    this.didChangeFormSingle,
    this.didChangeFormMultiple,
    this.enabled = true,
    this.streamController,
  }) : super(key: key);

  /// MenuData
  final List<TekInputDropdownItemModel<T>> menuChildren;

  /// Type
  final TekInputDropdownType type;
  final bool closeAfterSelect;

  /// Value & Action
  final String? valueSingle;
  final List<String>? valueMultiple;
  final Function(T?)? onChangedSingle;
  final Function(T?, List<T>)? onChangedMultiple;

  /// Text Field
  final TekInputSize size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText;
  final Color? cursorColor;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onEditingComplete;
  final Function(String?)? onSubmitted;
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
  final bool readOnly;

  /// Dropdown
  final Offset? offset;
  final double? maxHeightPopup;
  final double? minHeightPopup;
  final double? maxWidthPopup;
  final double? minWidthPopup;
  final bool tagsAbleScroll;
  final bool ableClearValue;
  final int dropdownItemMaxLines;
  final AlignmentGeometry? dropdownItemAlignment;
  final MainAxisAlignment? dropdownItemMainAxisAlignment;
  final Function(TekInputDropdownItemModel<T>?)? didChangeFormSingle;
  final Function(List<TekInputDropdownItemModel<T>>?)? didChangeFormMultiple;
  final bool enabled;
  final StreamController<TekInputDropdownStreamState<T>>? streamController;

  @override
  State<TekInputDropdown<T>> createState() => TekInputDropdownState<T>();
}

class TekInputDropdownState<T> extends State<TekInputDropdown<T>>
    with SingleTickerProviderStateMixin {
  /// Animation
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  StreamSubscription<TekInputDropdownStreamState<T>>? _listenerStreamState;

  /// Values
  late List<TekInputDropdownItemModel<T>> _menuChildren;

  String? _valueSingle;

  List<String>? _valueMultiple;

  /// Input
  final TextEditingController _controller = TextEditingController();

  /// Dropdown
  final MenuController _menuController = MenuController();

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

  bool get _ableClearValue {
    if (!widget.enabled) return false;
    return widget.ableClearValue;
  }

  TekInputDropdownItemModel<T>? get fromSingleKey {
    return _menuChildren.firstWhereOrNull((element) => element.keyValue == _valueSingle);
  }

  List<TekInputDropdownItemModel<T>>? get fromMultipleKey {
    if (_valueMultiple == null) return null;
    if (_valueMultiple!.isEmpty) return [];
    return _menuChildren.where((element) => _valueMultiple!.contains(element.keyValue)).toList();
  }

  void _listenStream(TekInputDropdownStreamState<T> event) {
    if (widget.type.isSingle) {
      if (event.valueSingle?.keyValue != _valueSingle) {
        _setValue(
          valueSingle: event.valueSingle,
        );
      }
    } else {
      if (!TekEqual.isEqual(event.valueMultiple?.map((e) => e.keyValue).toList(), _valueMultiple)) {
        _setValue(
          valueMultiple: event.valueMultiple,
        );
      }
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

    _valueSingle = widget.valueSingle;
    _valueMultiple = widget.valueMultiple;
    _menuChildren = widget.menuChildren;
    _setValue(
      valueSingle: fromSingleKey,
      valueMultiple: fromMultipleKey,
      callOnChanged: false,
      callSetState: false,
      isInitTime: true,
    );
    _listenerStreamState = widget.streamController?.stream.listen(_listenStream);
  }

  @override
  void didUpdateWidget(covariant TekInputDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menuChildren != oldWidget.menuChildren) {
      setState(() => _menuChildren = widget.menuChildren);
    }
    if (widget.type.isSingle) {
      if (_valueSingle != widget.valueSingle) {
        _valueSingle = widget.valueSingle;
        _setValue(
          valueSingle: fromSingleKey,
          isInitTime: true,
          callOnChanged: false,
        );
      }
    } else {
      if (!TekEqual.isEqual(widget.valueMultiple, _valueMultiple)) {
        _valueMultiple = widget.valueMultiple;
        _setValue(
          valueMultiple: fromMultipleKey,
          isInitTime: true,
          callOnChanged: false,
        );
      }
    }
  }

  @override
  void dispose() {
    _listenerStreamState?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _setValue({
    TekInputDropdownItemModel<T>? valueSingle,
    List<TekInputDropdownItemModel<T>>? valueMultiple,
    bool isInitTime = false,
    bool callOnChanged = true,
    bool callSetState = true,
  }) {
    if (widget.type.isSingle) {
      if (valueSingle != null) {
        _valueSingle = valueSingle.keyValue;
        _controller.text = valueSingle.label;
      } else {
        _valueSingle = null;
        _controller.clear();
      }
      if (callSetState) {
        widget.didChangeFormSingle?.call(valueSingle);
        setState(() {});
      }
      if (!isInitTime) _menuController.close();
    } else {
      if (valueMultiple != null) {
        _valueMultiple = valueMultiple.map((e) => e.keyValue).toList();
      } else {
        _valueMultiple = null;
      }
      if (callSetState) {
        widget.didChangeFormMultiple?.call(valueMultiple);
        setState(() {});
      }
      if (widget.closeAfterSelect) if (!isInitTime) _menuController.close();
    }
    if (callOnChanged) {
      if (widget.type.isSingle) {
        widget.onChangedSingle?.call(valueSingle?.value);
      } else {
        widget.onChangedMultiple?.call(
          valueSingle?.value,
          valueMultiple?.map((e) => e.value).toList() ?? [],
        );
      }
    }
  }

  void _setPopupIsOpen(bool value) {
    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handleSelectItem({
    required TekInputDropdownItemModel<T> item,
  }) {
    try {
      if (widget.type.isSingle) {
        _setValue(valueSingle: item);
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        final List<TekInputDropdownItemModel<T>> currentValueMultiple = fromMultipleKey ?? [];
        final index = currentValueMultiple.indexWhere(
          (element) => element.keyValue == item.keyValue,
        );
        if (index == -1) {
          currentValueMultiple.add(item);
        } else {
          currentValueMultiple.removeAt(index);
        }
        _setValue(
          valueSingle: item,
          valueMultiple: currentValueMultiple,
        );
      }
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown handleSelectItem error : $e");
    }
  }

  void _handleRemoveItem({
    required TekInputDropdownItemModel<T> item,
  }) {
    try {
      final List<TekInputDropdownItemModel<T>> currentValueMultiple = fromMultipleKey ?? [];
      currentValueMultiple.removeWhere((element) => element.keyValue == item.keyValue);
      _setValue(valueMultiple: currentValueMultiple);
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown handleRemoveItem error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildDropdownButton();
  }

  Widget _buildDropdownButton() {
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
                widget.minHeightPopup ?? _menuChildren.length * _getSizeDropdownItem.height + 11,
              ),
            ),
            maximumSize: MaterialStateProperty.all(
              Size(
                widget.maxWidthPopup ?? width,
                widget.maxHeightPopup ?? _menuChildren.length * _getSizeDropdownItem.height + 11,
              ),
            ),
            visualDensity: VisualDensity.comfortable,
          ),
          menuChildren: _menuChildren.map(
            (item) {
              return TekButton(
                width: double.infinity,
                size: _getSizeDropdownItem,
                onPressed: () => _handleSelectItem(
                  item: item,
                ),
                mainAxisAlignment: widget.dropdownItemMainAxisAlignment ?? MainAxisAlignment.start,
                alignment: widget.dropdownItemAlignment ?? Alignment.centerLeft,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                background: _getItemColor(
                  item: item,
                ),
                mainAxisSize: MainAxisSize.max,
                text: item.child == null ? item.label : null,
                maxLines: widget.dropdownItemMaxLines,
                child: _getDropdownItem(
                  item: item,
                ),
              );
            },
          ).toList(),
          builder: (context, controller, child) {
            return TekTextField(
              size: widget.size,
              width: widget.width,
              controller: _controller,
              focusNode: widget.focusNode,
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
              inputFormatters: widget.inputFormatters,
              onTap: () {
                if (!widget.enabled) return;
                if (!widget.readOnly) {
                  if (_menuController.isOpen) {
                    _menuController.close();
                  } else {
                    _menuController.open();
                  }
                }
                widget.onTap?.call();
              },
              onTapOutside: widget.onTapOutside,
              onEditingComplete: widget.onEditingComplete,
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
              hintText: widget.type.isSingle ? widget.hintText : null,
              hintStyle: widget.hintStyle,
              errorText: widget.errorText,
              errorMaxLines: widget.errorMaxLines,
              errorStyle: widget.errorStyle,
              readOnly: true,
              ablePrefixIconConstraints: !widget.type.isMulti,
            );
          },
        );
      },
    );
  }

  Color _getItemColor({
    required TekInputDropdownItemModel<T> item,
  }) {
    try {
      if (widget.type.isSingle) {
        final dataState = fromSingleKey;
        if (item.keyValue != dataState?.keyValue) return Colors.transparent;
        return TekColors().primaryOpacity01;
      } else {
        final List<TekInputDropdownItemModel<T>> currentValueMultiple = fromMultipleKey ?? [];
        final filter = currentValueMultiple.firstWhereOrNull((e) => e.keyValue == item.keyValue);
        if (filter == null) return Colors.transparent;
        return TekColors().primaryOpacity01;
      }
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown getItemColor error : $e");
      return Colors.transparent;
    }
  }

  Widget _getSuffixIcon() {
    if (((widget.type.isSingle && _valueSingle != null) ||
            (widget.type.isMulti && _valueMultiple != null && _valueMultiple!.isNotEmpty)) &&
        _ableClearValue) {
      return TekButtonInkwell(
        onPressed: () => _setValue(valueSingle: null, valueMultiple: null),
        child: RotationTransition(
          turns: _rotateAnimation,
          child: Icon(
            Icons.cancel_rounded,
            size: TekIconSizes().s20,
          ),
        ),
      );
    }
    return RotationTransition(
      turns: _rotateAnimation,
      child: Icon(
        Icons.expand_more_rounded,
        size: TekIconSizes().s24,
      ),
    );
  }

  final _scrollController = ScrollController();

  Widget? _getPrefixIcon() {
    if (widget.type.isSingle) return widget.prefixIcon;
    try {
      final selectedItems = fromMultipleKey ?? [];
      if (selectedItems.isEmpty) return null;
      final Widget prefixIcon = Padding(
        padding: EdgeInsets.all(TekSpacings().p8),
        child: Wrap(
          runSpacing: TekSpacings().p8,
          spacing: TekSpacings().p8,
          children: selectedItems.map(
            (item) {
              return TekDynamicTag(
                textContent: item.label,
                whenClose: () => _handleRemoveItem(item: item),
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
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown getPrefixIcon error : $e");
      return null;
    }
  }

  Widget? _getDropdownItem({
    required TekInputDropdownItemModel<T> item,
  }) {
    if (item.child != null) return item.child!(item.value, item.label);
    if (widget.type.isSingle) return null;
    final filter = (fromMultipleKey ?? []).firstWhereOrNull((e) => e.keyValue == item.keyValue);
    if (filter == null) return null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            item.label,
            maxLines: widget.dropdownItemMaxLines,
          ),
        ),
        Icon(
          Icons.check_rounded,
          color: TekColors().primary,
        )
      ],
    );
  }
}