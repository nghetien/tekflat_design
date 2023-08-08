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

    /// Form
    this.name = '',
    this.initialValues = const [],
    this.focusNodeForm,
    this.enabled = true,
    this.autoValidateMode,
    this.restorationId,
    this.validator,
    this.valueTransformer,
    this.onSaved,
    this.onDropdownChanged,
    this.onReset,
    this.onSelected,

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
    this.onChanged,
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
  }) : super(key: key);

  /// MenuData
  final List<TekInputDropdownItemModel<T>> menuChildren;

  /// Type
  final TekInputDropdownType type;
  final bool closeAfterSelect;

  /// Form
  final String name;
  final List<String> initialValues;
  final FocusNode? focusNodeForm;
  final bool enabled;
  final AutovalidateMode? autoValidateMode;
  final String? restorationId;
  final String? Function(dynamic)? validator;
  final dynamic Function(dynamic)? valueTransformer;
  final Function(dynamic)? onSaved;
  final Function(dynamic)? onDropdownChanged;
  final Function()? onReset;
  final Function(T, List<T>)? onSelected;

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
  final ValueChanged<String?>? onChanged;
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

  @override
  State<TekInputDropdown<T>> createState() => TekInputDropdownState<T>();
}

class TekInputDropdownState<T> extends State<TekInputDropdown<T>>
    with SingleTickerProviderStateMixin {
  /// Animation
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  /// Values
  late List<TekInputDropdownItemModel<T>> _menuChildren;

  TekInputDropdownItemModel<T>? _initValueTypeSingle;

  List<TekInputDropdownItemModel<T>>? _initValueTypeMultiple;

  /// Input
  late final TextEditingController _controller;

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
    if (widget.type.isSingle) {
      if (widget.initialValues.isNotEmpty) {
        _initValueTypeSingle = widget.menuChildren.firstWhereOrNull(
          (element) => element.keyValue == widget.initialValues.first,
        );
        _controller = TextEditingController(text: _initValueTypeSingle?.label);
      } else {
        _controller = TextEditingController();
      }
    } else {
      final filter = widget.menuChildren
          .where(
            (element) => widget.initialValues.contains(element.keyValue),
          )
          .toList();
      if (filter.isNotEmpty) _initValueTypeMultiple = filter;
      _controller = TextEditingController();
    }
  }

  @override
  void didUpdateWidget(TekInputDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menuChildren != oldWidget.menuChildren) {
      setState(() => _menuChildren = widget.menuChildren);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setPopupIsOpen(bool value) {
    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onFocusChange<ValueType>({
    bool? hasFocus,
    required FormFieldState<ValueType> state,
  }) {
    if (hasFocus == null || hasFocus == false) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (_menuController.isOpen) return;
    _menuController.open();
  }

  void _handleSelectItem<ValueType>({
    required FormFieldState<ValueType> state,
    required TekInputDropdownItemModel<T> item,
  }) {
    try {
      if (widget.type.isSingle) {
        state.didChange(item as ValueType);
        _controller.text = item.label;
        _menuController.close();
        widget.onSelected?.call(item.value, [item.value]);
      } else {
        final List<TekInputDropdownItemModel<T>> currentValueMultiple =
            state.value as List<TekInputDropdownItemModel<T>>? ?? [];
        final index = currentValueMultiple.indexWhere(
          (element) => element.keyValue == item.keyValue,
        );
        if (index == -1) {
          currentValueMultiple.add(item);
        } else {
          currentValueMultiple.removeAt(index);
        }
        state.didChange(currentValueMultiple as ValueType);
        if (widget.closeAfterSelect) _menuController.close();
        widget.onSelected?.call(item.value, currentValueMultiple.map((e) => e.value).toList());
        setState(() {});
      }
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown handleSelectItem error : $e");
    }
  }

  void _handleRemoveItem<ValueType>({
    required FormFieldState<ValueType> state,
    required TekInputDropdownItemModel<T> item,
  }) {
    try {
      final List<TekInputDropdownItemModel<T>> currentValueMultiple =
          state.value as List<TekInputDropdownItemModel<T>>? ?? [];
      currentValueMultiple.remove(item);
      state.didChange(currentValueMultiple as ValueType);
      widget.onSelected?.call(item.value, currentValueMultiple.map((e) => e.value).toList());
      setState(() {});
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown handleRemoveItem error : $e");
    }
  }

  void _onDropdownChanged<ValueType>(ValueType? value){
    widget.onDropdownChanged?.call(value);
    try{
      if(widget.type.isSingle){
        final convertValue = value as TekInputDropdownItemModel<T>?;
        if(convertValue != null){
          _controller.text = convertValue.label;
        }
      }
    }catch(e){
      TekLogger.errorLog("TekInputDropdown onDropdownChanged error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type.isSingle) {
      return _buildDropdownButton<TekInputDropdownItemModel<T>?>(
        initialValue: _initValueTypeSingle,
      );
    }
    return _buildDropdownButton<List<TekInputDropdownItemModel<T>>?>(
      initialValue: _initValueTypeMultiple,
    );
  }

  Widget _buildDropdownButton<ValueType>({
    ValueType? initialValue,
  }) {
    return FormBuilderField<ValueType>(
      name: widget.name,
      initialValue: initialValue,
      focusNode: widget.focusNodeForm,
      enabled: widget.enabled,
      autovalidateMode: widget.autoValidateMode,
      restorationId: widget.restorationId,
      validator: widget.validator,
      valueTransformer: widget.valueTransformer,
      onSaved: widget.onSaved,
      onChanged: _onDropdownChanged,
      onReset: widget.onReset,
      builder: (FormFieldState<ValueType> state) {
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
                        _menuChildren.length * _getSizeDropdownItem.height + 11,
                  ),
                ),
                maximumSize: MaterialStateProperty.all(
                  Size(
                    widget.maxWidthPopup ?? width,
                    widget.maxHeightPopup ??
                        _menuChildren.length * _getSizeDropdownItem.height + 11,
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
                      state: state,
                      item: item,
                    ),
                    mainAxisAlignment: MainAxisAlignment.start,
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    background: _getItemColor(
                      item: item,
                      state: state,
                    ),
                    mainAxisSize: MainAxisSize.max,
                    text: item.child == null ? item.label : null,
                    child: _getDropdownItem(
                      state: state,
                      item: item,
                    ),
                  );
                },
              ).toList(),
              builder: (context, controller, child) {
                return Focus(
                  onFocusChange: (hasFocus) => _onFocusChange<ValueType>(
                    hasFocus: hasFocus,
                    state: state,
                  ),
                  child: TekInput(
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
                    onChanged: widget.onChanged,
                    onTap: widget.onTap,
                    onTapOutside: widget.onTapOutside,
                    onEditingComplete: widget.onEditingComplete,
                    onSubmitted: widget.onSubmitted,
                    isDense: widget.isDense,
                    filled: widget.filled,
                    prefixIcon: _getPrefixIcon(state),
                    suffixIcon: _getSuffixIcon(state),
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
                    errorText: widget.errorText ?? state.errorText,
                    errorMaxLines: widget.errorMaxLines,
                    errorStyle: widget.errorStyle,
                    readOnly: true,
                    ablePrefixIconConstraints: !widget.type.isMulti,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Color _getItemColor<ValueType>({
    required TekInputDropdownItemModel<T> item,
    required FormFieldState<ValueType> state,
  }) {
    try {
      if (widget.type.isSingle) {
        final dataState = state.value as TekInputDropdownItemModel<T>?;
        if (item.keyValue != dataState?.keyValue) return Colors.transparent;
        return TekColors().primaryOpacity01;
      }
      final List<TekInputDropdownItemModel<T>> currentValueMultiple =
          state.value as List<TekInputDropdownItemModel<T>>? ?? [];
      final filter = currentValueMultiple.firstWhereOrNull((e) => e.keyValue == item.keyValue);
      if (filter == null) return Colors.transparent;
      return TekColors().primaryOpacity01;
    } catch (e) {
      TekLogger.errorLog("TekInputDropdown getItemColor error : $e");
      return Colors.transparent;
    }
  }

  Widget _getSuffixIcon<ValueType>(FormFieldState<ValueType> state) {
    if (state.value != null && widget.ableClearValue) {
      return TekButtonInkwell(
        onPressed: () {
          state.didChange(null);
          _controller.clear();
          widget.onDropdownChanged?.call(null);
          FocusManager.instance.primaryFocus?.unfocus();
          _menuController.close();
          setState(() {});
        },
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

  Widget? _getPrefixIcon<ValueType>(FormFieldState<ValueType> state) {
    if (widget.type.isSingle) return widget.prefixIcon;
    try {
      final selectedItems = state.value as List<TekInputDropdownItemModel<T>>? ?? [];
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
                whenClose: () => _handleRemoveItem(item: item, state: state),
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

  Widget? _getDropdownItem<ValueType>({
    required TekInputDropdownItemModel<T> item,
    required FormFieldState<ValueType> state,
  }) {
    if (item.child != null) return item.child!(item.value, item.label);
    if (widget.type.isSingle) return null;
    final filter = (state.value as List<TekInputDropdownItemModel<T>>? ?? [])
        .firstWhereOrNull((e) => e.keyValue == item.keyValue);
    if (filter == null) return null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            item.label,
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
