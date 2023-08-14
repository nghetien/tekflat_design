part of 'inputs.dart';

class TekInputDropdownStreamState<T> {
  final List<TekInputDropdownItemModel<T>>? valueMultiple;
  final TekInputDropdownItemModel<T>? valueSingle;

  const TekInputDropdownStreamState({
    this.valueMultiple,
    this.valueSingle,
  });
}

class TekInputDropdownForm<T> extends StatefulWidget {
  const TekInputDropdownForm({
    Key? key,

    /// MenuDate
    this.menuChildren = const [],

    /// Type
    this.type = TekInputDropdownType.single,
    this.closeAfterSelect = false,

    /// Form
    this.name = '',
    this.initialValue,
    this.initialValues,
    this.focusNodeForm,
    this.enabled = true,
    this.autoValidateMode,
    this.restorationId,
    this.validatorSingle,
    this.validatorMultiple,
    this.valueTransformerSingle,
    this.valueTransformerMultiple,
    this.onSavedSingle,
    this.onSavedMultiple,
    this.onDropdownChangedSingle,
    this.onDropdownChangedMultiple,
    this.onReset,
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
  }) : super(key: key);

  /// MenuData
  final List<TekInputDropdownItemModel<T>> menuChildren;

  /// Type
  final TekInputDropdownType type;
  final bool closeAfterSelect;

  /// Form
  final String name;
  final String? initialValue;
  final List<String>? initialValues;
  final FocusNode? focusNodeForm;
  final bool enabled;
  final AutovalidateMode? autoValidateMode;
  final String? restorationId;
  final String? Function(TekInputDropdownItemModel<T>?)? validatorSingle;
  final String? Function(List<TekInputDropdownItemModel<T>>?)? validatorMultiple;
  final dynamic Function(TekInputDropdownItemModel<T>?)? valueTransformerSingle;
  final dynamic Function(List<TekInputDropdownItemModel<T>>?)? valueTransformerMultiple;
  final Function(TekInputDropdownItemModel<T>?)? onSavedSingle;
  final Function(List<TekInputDropdownItemModel<T>>?)? onSavedMultiple;
  final Function(TekInputDropdownItemModel<T>?)? onDropdownChangedSingle;
  final Function(List<TekInputDropdownItemModel<T>>?)? onDropdownChangedMultiple;
  final Function()? onReset;
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

  @override
  State<TekInputDropdownForm<T>> createState() => _TekInputDropdownFormState<T>();
}

class _TekInputDropdownFormState<T> extends State<TekInputDropdownForm<T>> {
  final StreamController<TekInputDropdownStreamState<T>> _stateStreamController =
      StreamController<TekInputDropdownStreamState<T>>.broadcast();

  List<TekInputDropdownItemModel<T>> _menuChildren = [];

  TekInputDropdownItemModel<T>? get fromSingleKey {
    return _menuChildren.firstWhereOrNull((element) => element.keyValue == widget.initialValue);
  }

  List<TekInputDropdownItemModel<T>>? get fromMultipleKey {
    return _menuChildren
        .where((element) => widget.initialValues!.contains(element.keyValue))
        .toList();
  }

  @override
  void initState() {
    _menuChildren = widget.menuChildren;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TekInputDropdownForm<T> oldWidget) {
    if (oldWidget.menuChildren != widget.menuChildren) {
      _menuChildren = widget.menuChildren;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onChangedSingle(TekInputDropdownItemModel<T>? value) {
    _stateStreamController.add(TekInputDropdownStreamState<T>(valueSingle: value));
    widget.onDropdownChangedSingle?.call(value);
  }

  void _onChangedMultiple(List<TekInputDropdownItemModel<T>>? value) {
    _stateStreamController.add(TekInputDropdownStreamState<T>(valueMultiple: value));
    widget.onDropdownChangedMultiple?.call(value);
  }

  void _onReset() {
    if (widget.type.isSingle) {
      _stateStreamController.add(const TekInputDropdownStreamState(valueSingle: null));
    } else {
      _stateStreamController.add(const TekInputDropdownStreamState(valueMultiple: null));
    }
    widget.onReset?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type.isSingle) {
      return FormBuilderField<TekInputDropdownItemModel<T>?>(
        name: widget.name,
        initialValue: fromSingleKey,
        focusNode: widget.focusNodeForm,
        enabled: widget.enabled,
        autovalidateMode: widget.autoValidateMode,
        restorationId: widget.restorationId,
        validator: widget.validatorSingle,
        valueTransformer: widget.valueTransformerSingle,
        onSaved: widget.onSavedSingle,
        onChanged: _onChangedSingle,
        onReset: _onReset,
        builder: (FormFieldState<TekInputDropdownItemModel<T>?> state) {
          return _buildDropdownButtonSingle(state);
        },
      );
    }
    return FormBuilderField<List<TekInputDropdownItemModel<T>>?>(
      name: widget.name,
      initialValue: fromMultipleKey,
      focusNode: widget.focusNodeForm,
      enabled: widget.enabled,
      autovalidateMode: widget.autoValidateMode,
      restorationId: widget.restorationId,
      validator: widget.validatorMultiple,
      valueTransformer: widget.valueTransformerMultiple,
      onSaved: widget.onSavedMultiple,
      onChanged: _onChangedMultiple,
      onReset: _onReset,
      builder: (FormFieldState<List<TekInputDropdownItemModel<T>>?> state) {
        return _buildDropdownButtonMultiple(state);
      },
    );
  }

  Widget _buildDropdownButtonSingle(FormFieldState<TekInputDropdownItemModel<T>?> state) {
    return TekInputDropdown<T>(
      menuChildren: widget.menuChildren,
      type: widget.type,
      closeAfterSelect: widget.closeAfterSelect,
      valueSingle: state.value?.keyValue,
      onChangedSingle: widget.onChangedSingle,
      size: widget.size,
      width: widget.width,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: widget.obscureText,
      cursorColor: widget.cursorColor,
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      isDense: widget.isDense,
      filled: widget.filled,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
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
      errorText: widget.errorText ?? state.errorText,
      errorMaxLines: widget.errorMaxLines,
      errorStyle: widget.errorStyle,
      readOnly: widget.readOnly,
      offset: widget.offset,
      maxHeightPopup: widget.maxHeightPopup,
      minHeightPopup: widget.minHeightPopup,
      maxWidthPopup: widget.maxWidthPopup,
      minWidthPopup: widget.minWidthPopup,
      tagsAbleScroll: widget.tagsAbleScroll,
      ableClearValue: widget.ableClearValue,
      dropdownItemMaxLines: widget.dropdownItemMaxLines,
      enabled: widget.enabled,
      didChangeFormSingle: state.setValue,
      streamController: _stateStreamController,
    );
  }

  Widget _buildDropdownButtonMultiple(FormFieldState<List<TekInputDropdownItemModel<T>>?> state) {
    return TekInputDropdown<T>(
      menuChildren: widget.menuChildren,
      type: widget.type,
      closeAfterSelect: widget.closeAfterSelect,
      valueMultiple: state.value?.map((e) => e.keyValue).toList(),
      onChangedMultiple: widget.onChangedMultiple,
      size: widget.size,
      width: widget.width,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: widget.obscureText,
      cursorColor: widget.cursorColor,
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      isDense: widget.isDense,
      filled: widget.filled,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
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
      errorText: widget.errorText ?? state.errorText,
      errorMaxLines: widget.errorMaxLines,
      errorStyle: widget.errorStyle,
      readOnly: widget.readOnly,
      offset: widget.offset,
      maxHeightPopup: widget.maxHeightPopup,
      minHeightPopup: widget.minHeightPopup,
      maxWidthPopup: widget.maxWidthPopup,
      minWidthPopup: widget.minWidthPopup,
      tagsAbleScroll: widget.tagsAbleScroll,
      ableClearValue: widget.ableClearValue,
      dropdownItemMaxLines: widget.dropdownItemMaxLines,
      enabled: widget.enabled,
      didChangeFormMultiple: state.setValue,
      streamController: _stateStreamController,
    );
  }
}
