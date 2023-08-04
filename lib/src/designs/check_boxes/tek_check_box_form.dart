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
    this.type = TekCheckBoxType.check,
    this.initValue = false,
    this.activeColor,
    this.checkColor,
    this.space,
    this.titleWidget,
    this.title,
    this.textStyle,
    this.validator,
    this.valueTransformer,
    this.onChanged,
    this.onReset,
    this.onSaved,
    this.side,
    this.borderWidth,
    this.mainColor,
    this.enabled = true,
  })  : assert((title == null && titleWidget != null) || (title != null && titleWidget == null),
            'each of title and titleWidget must be null'),
        super(key: key);

  final String name;
  final TekCheckBoxType type;
  final bool initValue;
  final Color? activeColor;
  final Color? checkColor;
  final double? space;
  final Widget? titleWidget;
  final String? title;
  final TextStyle? textStyle;
  final String? Function(bool?)? validator;
  final dynamic Function(bool?)? valueTransformer;
  final Function(bool?)? onChanged;
  final Function()? onReset;
  final Function(bool?)? onSaved;
  final BorderSide? side;
  final double? borderWidth;
  final Color? mainColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) => FormBuilderField<bool>(
        name: name,
        initialValue: initValue,
        valueTransformer: valueTransformer,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        onReset: onReset,
        enabled: enabled,
        builder: (state) => TekCheckBox(
          value: state.value ?? false,
          onChanged: state.didChange,
          activeColor: activeColor,
          checkColor: checkColor,
          space: space,
          titleWidget: titleWidget,
          title: title,
          textStyle: textStyle,
          type: type,
          side: side,
          borderWidth: borderWidth,
          mainColor: mainColor,
          enabled: enabled,
        ),
      );
}
