part of 'buttons.dart';

class TekButtonInkwell extends StatelessWidget {
  const TekButtonInkwell({
    Key? key,
    this.text,
    this.child,
    this.onPressed,
    this.onHover,
    this.textColor,
    this.textFontSize,
    this.textFontWeight,
  }) : super(key: key);

  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Function(bool)? onHover;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        onHover: onHover,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        child: child ?? Text(
          text ?? "",
          style: TekTextStyles().body.copyWith(
            color: textColor,
            fontSize: textFontSize,
            fontWeight: textFontWeight,
            height: 0,
          ),
        )
    );
  }
}
