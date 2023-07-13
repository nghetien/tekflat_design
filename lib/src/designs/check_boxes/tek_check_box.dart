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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? type.style.activeColor,
          checkColor: checkColor ?? type.style.checkColor,
          shape: type.style.shape,
          side: BorderSide(width: TekBorders.med, color: TekColors().primary),
        ),
        HSpace(space ?? TekPaddings().p8),
        titleWidget ??
            Text(
              title ?? '',
              style: textStyle ??
                  TekTextStyles.body.copyWith(
                    color: value ? activeColor ?? TekColors().primary : null,
                  ),
            ),
      ],
    );
  }
}
