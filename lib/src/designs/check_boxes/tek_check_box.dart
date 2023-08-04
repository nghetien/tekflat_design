part of 'check_boxes.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: enabled ? (activeColor ?? type.style.activeColor) : TekColors.grey,
          checkColor: enabled ? (checkColor ?? type.style.checkColor) : TekColors.grey,
          shape: type.style.shape,
          side: side ??
              BorderSide(
                width: borderWidth ?? context.theme.checkboxTheme.side!.width,
                color:
                    enabled ? mainColor ?? context.theme.checkboxTheme.side!.color : TekColors.grey,
              ),
        ),
        TekHSpace(space ?? TekSpacings().p8),
        titleWidget ??
            Text(
              title ?? '',
              style: textStyle ??
                  TekTextStyles.body.copyWith(
                    color: value ? activeColor ?? TekColors().primary : mainColor,
                  ),
            ),
      ],
    );
  }
}
