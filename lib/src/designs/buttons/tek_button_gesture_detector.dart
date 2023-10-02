part of 'buttons.dart';

class TekButtonGD extends StatelessWidget {
  const TekButtonGD({
    Key? key,
    this.text,
    this.child,
    this.onPressed,
    this.textColor,
    this.textFontSize,
    this.textFontWeight,
    this.iconData,
    this.size,
    this.color,
    this.icon,
    this.cursor = SystemMouseCursors.click,
    this.maxLines,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.spacing,
    this.iconFirst = true,
  }) : super(key: key);

  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final IconData? iconData;
  final double? size;
  final Color? color;
  final Widget? icon;
  final MouseCursor cursor;
  final int? maxLines;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final double? spacing;
  final bool iconFirst;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: cursor,
        child: _getChild(),
      ),
    );
  }

  Widget? _getIcon() {
    return iconData != null
        ? Icon(
            iconData,
            size: size,
            color: color,
          )
        : icon;
  }

  Widget? _getText() {
    return Text(
      text ?? "",
      style: TekTextStyles().body.copyWith(
        color: textColor,
        fontSize: textFontSize,
        fontWeight: textFontWeight,
        height: 0,
      ),
      maxLines: maxLines,
    );
  }

  Widget _getChild() {
    if (child != null) return child!;
    if (text != null && iconData == null && icon == null) return _getText()!;
    if (text == null && iconData != null && icon == null) return _getIcon()!;
    if (text == null && iconData == null && icon != null) return icon!;
    final textChild = _getText();
    final iconChild = _getIcon();
    if (iconFirst) {
      Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        children: [
          if (iconChild != null) _getIcon()!,
          if (iconChild != null && textChild != null)
            SizedBox(
              width: spacing ?? TekSpacings().mainSpacing,
            ),
          if (textChild != null) _getText()!,
        ],
      );
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      children: [
        if (textChild != null) _getText()!,
        if (textChild != null && iconChild != null)
          SizedBox(
            width: spacing ?? TekSpacings().mainSpacing,
          ),
        if (iconChild != null) _getIcon()!,
      ],
    );
  }
}
