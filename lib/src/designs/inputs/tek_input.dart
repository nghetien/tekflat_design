part of 'inputs.dart';

enum TekInputSize {
  extraLarge,
  large,
  medium,
  areaSmall,
  areaMedium,
  areaLarge;

  double get height {
    switch (this) {
      case TekInputSize.extraLarge:
        return 56;
      case TekInputSize.large:
        return 48;
      case TekInputSize.medium:
        return 40;
      case TekInputSize.areaSmall:
        return 60;
      case TekInputSize.areaMedium:
        return 80;
      case TekInputSize.areaLarge:
        return 100;
      default:
        return 48;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case TekInputSize.extraLarge:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: TekPlatform.isWeb ? 20.scaleSpacing : 16.scaleSpacing,
        );
      case TekInputSize.large:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: TekPlatform.isWeb ? 16.scaleSpacing : 12.scaleSpacing,
        );
      case TekInputSize.medium:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: TekPlatform.isWeb ? 13.5.scaleSpacing : 9.5.scaleSpacing,
        );
      case TekInputSize.areaSmall:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: 12.scaleSpacing,
        );
      case TekInputSize.areaMedium:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: 12.scaleSpacing,
        );
      case TekInputSize.areaLarge:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: 12.scaleSpacing,
        );
      default:
        return EdgeInsets.symmetric(
          horizontal: 12.scaleSpacing,
          vertical: 12.scaleSpacing,
        );
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case TekInputSize.extraLarge:
        return TekTextStyles.titleMedium;
      case TekInputSize.large:
        return TekTextStyles.body;
      case TekInputSize.medium:
        return TekTextStyles.body;
      case TekInputSize.areaSmall:
        return TekTextStyles.body;
      case TekInputSize.areaMedium:
        return TekTextStyles.body;
      case TekInputSize.areaLarge:
        return TekTextStyles.body;
    }
  }

  TextStyle get hintStyle {
    switch (this) {
      case TekInputSize.extraLarge:
        return TekTextStyles.body;
      case TekInputSize.large:
        return TekTextStyles.body;
      case TekInputSize.medium:
        return TekTextStyles.body;
      case TekInputSize.areaSmall:
        return TekTextStyles.body;
      case TekInputSize.areaMedium:
        return TekTextStyles.body;
      case TekInputSize.areaLarge:
        return TekTextStyles.body;
    }
  }

  int get maxLines {
    switch (this) {
      case TekInputSize.extraLarge:
        return 1;
      case TekInputSize.large:
        return 1;
      case TekInputSize.medium:
        return 1;
      case TekInputSize.areaSmall:
        return 2;
      case TekInputSize.areaMedium:
        return 3;
      case TekInputSize.areaLarge:
        return 4;
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
    this.size = TekInputSize.medium,
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
    this.onTapOutside,
    this.onEditingComplete,
    this.onSaved,
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
  })  : assert(
          (initialValue == null && controller == null) ||
              (initialValue != null && controller == null) ||
              (initialValue == null && controller != null),
          'Cannot provide both a controller and a initial value',
        ),
        super(key: key);

  final GlobalKey? keyFormState;
  final String? name;
  final TekInputSize size;
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
  final Function(PointerDownEvent)? onTapOutside;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter? onSaved;
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

  EdgeInsets get _paddingContent {
    if (contentPadding != null) return contentPadding!;
    return size.padding;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: FormBuilderTextField(
          key: keyFormState,
          controller: controller,
          focusNode: focusNode,
          initialValue: initialValue,
          style: textStyle ?? size.textStyle,
          textAlign: textAlign,
          textInputAction: textInputAction,
          textAlignVertical: textAlignVertical,
          keyboardType: keyboardType,
          maxLines: maxLines ?? size.maxLines,
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
          onTapOutside: onTapOutside,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          onSubmitted: onSubmitted,
          readOnly: readOnly,
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
          name: name ?? '',
        ),
      );
}
