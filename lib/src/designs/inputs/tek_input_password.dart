part of 'inputs.dart';

class TekInputPassword extends StatefulWidget {
  const TekInputPassword({
    Key? key,
    this.name,
    this.iconPasswordColor,
    this.iconPasswordSize,
    this.size,
    this.width,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textInputAction,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.enabled = true,
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
  final double? iconPasswordSize;
  final Color? iconPasswordColor;
  final TekInputSize? size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final Color? cursorColor;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueTransformer<String?>? valueTransformer;
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
  State<TekInputPassword> createState() => _TekInputPasswordState();
}

class _TekInputPasswordState extends State<TekInputPassword> {
  bool _isShowPassword = false;

  Widget _getSuffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon!;
    return TekButtonGD(
      type: TekButtonGDType.icon,
      icon: Icon(
        _isShowPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
        color: widget.iconPasswordColor,
        size: widget.iconPasswordSize,
      ),
      onPressed: () => setState(() => _isShowPassword = !_isShowPassword),
    );
  }

  bool _getObscureText() => _isShowPassword ? false : true;

  @override
  Widget build(BuildContext context) => TekInput(
        name: widget.name,
        size: widget.size,
        width: widget.width,
        controller: widget.controller,
        focusNode: widget.focusNode,
        initialValue: widget.initialValue,
        textStyle: widget.textStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        obscureText: _getObscureText(),
        cursorColor: widget.cursorColor,
        autoValidateMode: widget.autoValidateMode,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        valueTransformer: widget.valueTransformer,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        onSaved: widget.onSaved,
        isDense: widget.isDense,
        filled: widget.filled,
        prefixIcon: widget.prefixIcon,
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
}
