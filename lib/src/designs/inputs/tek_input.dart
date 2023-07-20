part of 'inputs.dart';

enum TekInputSize {
  large,
  medium,
  areaSmall,
  areaMedium,
  areaLarge;

  TekInputStyle get style {
    switch (this) {
      case TekInputSize.large:
        return TekInputStyle(
          height: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          textStyle: TekTextStyles.titleMedium,
          hintStyle: TekTextStyles.titleMedium,
          maxLines: 1,
        );
      case TekInputSize.medium:
        return TekInputStyle(
          height: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13.5,
          ),
          textStyle: TekTextStyles.body,
          hintStyle: TekTextStyles.body,
          maxLines: 1,
        );
      case TekInputSize.areaSmall:
        return TekInputStyle(
          height: 60,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13,
          ),
          textStyle: TekTextStyles.body,
          hintStyle: TekTextStyles.body,
          maxLines: 2,
        );
      case TekInputSize.areaMedium:
        return TekInputStyle(
          height: 80,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12.5,
          ),
          textStyle: TekTextStyles.body,
          hintStyle: TekTextStyles.body,
          maxLines: 3,
        );
      case TekInputSize.areaLarge:
        return TekInputStyle(
          height: 100,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          textStyle: TekTextStyles.body,
          hintStyle: TekTextStyles.body,
          maxLines: 4,
        );
    }
  }
}

class TekInputStyle {
  final double height;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final int? maxLines;

  const TekInputStyle({
    required this.height,
    required this.padding,
    required this.textStyle,
    required this.hintStyle,
    this.maxLines,
  });
}

class TekInput extends StatelessWidget {
  const TekInput({
    Key? key,
    this.keyFormState,
    this.name,
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
    this.obscureText = false,
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

  final GlobalKey? keyFormState;
  final String? name;
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
  final bool obscureText;
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

  EdgeInsets _getPaddingContent() {
    if (contentPadding != null) return contentPadding!;
    final EdgeInsets padding = size?.style.padding ?? TekInputSize.large.style.padding;
    if (prefixIcon != null && suffixIcon != null) {
      return EdgeInsets.fromLTRB(0, padding.top, 0, padding.bottom);
    }
    if (prefixIcon != null) {
      return EdgeInsets.fromLTRB(0, padding.top, padding.right, padding.bottom);
    }
    if (suffixIcon != null) {
      return EdgeInsets.fromLTRB(padding.left, padding.top, 0, padding.bottom);
    }
    return padding;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
    child: FormBuilderTextField(
          key: keyFormState,
          controller: controller,
          focusNode: focusNode,
          initialValue: initialValue,
          style: textStyle ?? size?.style.textStyle,
          textAlign: textAlign,
          textInputAction: textInputAction,
          textAlignVertical: textAlignVertical,
          keyboardType: keyboardType,
          maxLines: maxLines ?? size?.style.maxLines,
          minLines: minLines,
          maxLength: maxLength,
          enabled: enabled,
          obscureText: obscureText,
          cursorColor: cursorColor,
          autovalidateMode: autoValidateMode,
          validator: validator,
          inputFormatters: inputFormatters,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          decoration: tekInputDecoration(
            context,
            enabled: enabled,
            isDense: isDense,
            filled: filled,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: _getPaddingContent(),
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
            hintStyle: hintStyle ?? size?.style.hintStyle,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            errorStyle: errorStyle,
          ),
          name: name ?? '',
        ),
      );
}
