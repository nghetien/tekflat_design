part of 'inputs.dart';

class TekTextField extends StatelessWidget {
  const TekTextField({
    Key? key,
    this.size = TekInputSize.medium,
    this.width,
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
    this.obscureText = false,
    this.cursorColor,
    this.inputFormatters,
    this.onChanged,
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
    this.ablePrefixIconConstraints = true,
    this.ableSuffixIconConstraints = true,
    this.readOnly = false,
    this.autofocus = false,
    this.expands = false,
  }) : super(key: key);

  final TekInputSize size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool obscureText;
  final Color? cursorColor;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String?>? onChanged;
  final GestureTapCallback? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSubmitted;
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
  final bool ableSuffixIconConstraints;
  final bool ablePrefixIconConstraints;
  final bool readOnly;
  final bool expands;
  final bool autofocus;

  EdgeInsets get _paddingContent {
    if (contentPadding != null) return contentPadding!;
    return size.padding;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: textStyle ?? size.textStyle,
          textAlign: textAlign,
          textInputAction: textInputAction,
          textAlignVertical: textAlignVertical,
          keyboardType: keyboardType,
          maxLines: expands ? null : (maxLines ?? size.maxLines),
          minLines: expands ? null : minLines,
          maxLength: maxLength,
          enabled: enabled,
          obscureText: obscureText,
          cursorColor: cursorColor,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onTap: onTap,
          onTapOutside: onTapOutside,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          readOnly: readOnly,
          expands: expands,
          autofocus: autofocus,
          decoration: tekInputDecoration(
            context: context,
            size: size,
            enabled: enabled,
            isDense: isDense,
            filled: filled,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: _paddingContent,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            disabledBorder: disabledBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
            fillColor: fillColor,
            hoverColor: hoverColor,
            labelText: labelText,
            labelStyle: labelStyle,
            floatingLabelStyle: floatingLabelStyle,
            floatingLabelBehavior: floatingLabelBehavior,
            hintText: hintText,
            hintStyle: hintStyle ?? size.hintStyle,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            errorStyle: errorStyle,
            ableSuffixIconConstraints: ableSuffixIconConstraints,
            ablePrefixIconConstraints: ablePrefixIconConstraints,
          ),
        ),
      );
}
