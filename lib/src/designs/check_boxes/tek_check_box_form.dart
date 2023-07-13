part of 'check_boxes.dart';

class TekCheckBoxStyle {
  final Color activeColor;
  final Color checkColor;
  final OutlinedBorder shape;

  const TekCheckBoxStyle({
    required this.checkColor,
    required this.activeColor,
    required this.shape,
  });
}

enum TekCheckBoxType {
  radio,
  check;

  bool get isRadio => this == TekCheckBoxType.radio;

  bool get isCheck => this == TekCheckBoxType.check;

  TekCheckBoxStyle get style {
    switch (this) {
      case TekCheckBoxType.radio:
        return TekCheckBoxStyle(
          activeColor: TekColors().primary,
          checkColor: TekColors().primary,
          shape: const CircleBorder(),
        );
      case TekCheckBoxType.check:
        return TekCheckBoxStyle(
          activeColor: TekColors().primary,
          checkColor: TekColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: TekCorners.cornerBorder3,
          ),
        );
    }
  }
}

class TekCheckBoxForm extends StatelessWidget {
  const TekCheckBoxForm({
    Key? key,
    this.name = '',
    this.title,
    this.titleText,
    this.titleTextStyle,
    this.titleTextFontWeight,
    this.contentPadding = EdgeInsets.zero,
    this.titleTextColor,
    this.type = TekCheckBoxType.check,
    this.initValue = false,
    this.selected = false,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.valueTransformer,
    this.enabled = true,
  }) : super(key: key);

  final String name;
  final Widget? title;
  final String? titleText;
  final TextStyle? titleTextStyle;
  final FontWeight? titleTextFontWeight;
  final Color? titleTextColor;
  final EdgeInsets contentPadding;
  final TekCheckBoxType type;
  final bool initValue;
  final bool selected;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final ValueTransformer? valueTransformer;
  final bool enabled;

  @override
  Widget build(BuildContext context) => FormBuilderCheckbox(
        name: name,
        title: title ??
            Text(
              titleText ?? '',
              style: titleTextStyle ??
                  TekTextStyles.body.copyWith(
                    color: titleTextColor,
                    fontWeight: titleTextFontWeight,
                  ),
            ),
        contentPadding: contentPadding,
        initialValue: initValue,
        selected: selected,
        onChanged: onChanged,
        activeColor: enabled ? (activeColor ?? type.style.activeColor) : TekColors.grey,
        checkColor: enabled ? (checkColor ?? type.style.checkColor) : TekColors.grey,
        shape: type.style.shape,
        side: BorderSide(
          width: TekBorders.med,
          color: enabled ? TekColors().primary : TekColors.grey,
        ),
        onReset: () => onChanged!(false),
        decoration: tekInputDecoration(
          context,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          fillColor: Colors.transparent,
        ),
        valueTransformer: valueTransformer,
        enabled: enabled,
      );
}
