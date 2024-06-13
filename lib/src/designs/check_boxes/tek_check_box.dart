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
          checkColor: TekColors().white,
          shape: const RoundedRectangleBorder(
            borderRadius: TekCorners.cornerBorder3,
          ),
        );
    }
  }
}

class TekCheckBox extends StatelessWidget {
  const TekCheckBox({
    Key? key,
    this.type = TekCheckBoxType.check,
    this.value = false,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.space,
    this.titleWidget,
    this.title,
    this.textStyle,
    this.side,
    this.borderWidth,
    this.mainColor,
    this.enabled = true,
  })  : assert((title == null && titleWidget != null) || (title != null && titleWidget == null),
            'each of title and titleWidget must be null'),
        super(key: key);

  final TekCheckBoxType type;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final double? space;
  final Widget? titleWidget;
  final String? title;
  final TextStyle? textStyle;
  final BorderSide? side;
  final double? borderWidth;
  final Color? mainColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TekButtonInkwell(
      onPressed: enabled ? () => onChanged?.call(!value) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getCheckBox(context),
          TekHSpace(space ?? TekSpacings().p8),
          titleWidget ??
              Text(
                title ?? '',
                style: textStyle ??
                    TekTextStyles().body.copyWith(
                      color: !enabled
                          ? TekColors().grey
                          : value
                              ? activeColor ?? TekColors().primary
                              : mainColor,
                    ),
              ),
        ],
      ),
    );
  }

  Widget _getCheckBox(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (value) {
        if (enabled) onChanged?.call(value);
      },
      activeColor: enabled ? (activeColor ?? type.style.activeColor) : TekColors().greyOpacity04,
      checkColor: enabled ? (checkColor ?? type.style.checkColor) : TekColors().greyOpacity04,
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (!states.contains(WidgetState.selected)) {
            return null;
          }
          return activeColor ?? TekColors().primary;
        },
      ),
      shape: type.style.shape,
      side: side ??
          BorderSide(
            width: borderWidth ?? context.theme.checkboxTheme.side!.width,
            color: enabled
                ? mainColor ?? context.theme.checkboxTheme.side!.color
                : TekColors().greyOpacity04,
          ),
    );
  }
}
