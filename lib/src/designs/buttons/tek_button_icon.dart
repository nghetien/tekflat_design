part of 'buttons.dart';

class TekButtonIcon extends StatelessWidget {
  const TekButtonIcon({
    Key? key,
    this.iconData,
    this.icon,
    this.spaceBetweenIconAndText,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.iconBeforeText = true,
    this.iconIsInEdge = false,
    this.size,
    this.type = TekButtonType.none,
    required this.onPressed,
    this.disabled = false,
    this.loading = false,
    this.text,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.background,
    this.hoverColor,
    this.shadowColor = Colors.transparent,
    this.elevation,
    this.boxShadow,
    this.splashFactory,
    this.shape,
    this.textColor,
    this.fontSize,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.maxLines = 4,
    this.alignment,
  }) : super(key: key);

  final IconData? iconData;
  final Icon? icon;
  final double? spaceBetweenIconAndText;
  final MainAxisSize? mainAxisSize;
  final MainAxisAlignment? mainAxisAlignment;
  final bool iconBeforeText;
  final bool iconIsInEdge;
  final TekButtonSize? size;
  final TekButtonType type;
  final VoidCallback onPressed;
  final bool disabled;
  final bool loading;
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? background;
  final Color? hoverColor;
  final Color shadowColor;
  final double? elevation;
  final InteractiveInkFeatureFactory? splashFactory;
  final List<BoxShadow>? boxShadow;
  final OutlinedBorder? shape;
  final Color? textColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int maxLines;
  final AlignmentGeometry? alignment;

  double _getDefaultSpaceBetweenIconAndText() {
    if (size == null) {
      return TekPaddings().p4;
    } else if (size == TekButtonSize.small) {
      return TekPaddings().p4;
    } else {
      return TekPaddings().p4;
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((icon == null && iconData == null) || loading) {
      return TekButton(
        key: key,
        size: size,
        type: type,
        onPressed: onPressed,
        disabled: disabled,
        loading: loading,
        text: text,
        width: width,
        height: height,
        padding: padding,
        background: background,
        hoverColor: hoverColor,
        shadowColor: shadowColor,
        elevation: elevation,
        boxShadow: boxShadow,
        splashFactory: splashFactory,
        shape: shape,
        textColor: textColor,
        fontSize: fontSize,
        textStyle: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        alignment: alignment,
        child: child,
      );
    }
    late final Widget children;
    if (text == null) {
      children = _getIcon(context);
    } else {
      children = Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        children: [
          if (iconBeforeText)
            Padding(
              padding: EdgeInsets.only(
                right: spaceBetweenIconAndText ?? _getDefaultSpaceBetweenIconAndText(),
              ),
              child: _getIcon(context),
            ),
          child ??
              _textWidget(
                iconIsInEdge: iconIsInEdge,
                child: Text(
                  text ?? '',
                  textAlign: TextAlign.center,
                  maxLines: maxLines,
                  style: textStyle ??
                      TekTextStyles.body.copyWith(
                        color: type.getTextColor(
                          context,
                          disabled: disabled,
                          loading: loading,
                          textColor: textColor,
                        ),
                        height: 0,
                      ),
                ),
              ),
          if (!iconBeforeText)
            Padding(
              padding: EdgeInsets.only(
                left: spaceBetweenIconAndText ?? _getDefaultSpaceBetweenIconAndText(),
              ),
              child: _getIcon(context),
            ),
        ],
      );
    }
    return TekButton(
      key: key,
      size: size,
      type: type,
      onPressed: onPressed,
      disabled: disabled,
      loading: loading,
      text: text,
      width: width,
      height: height,
      padding: padding,
      background: background,
      hoverColor: hoverColor,
      shadowColor: shadowColor,
      elevation: elevation,
      boxShadow: boxShadow,
      splashFactory: splashFactory,
      shape: shape,
      textColor: textColor,
      fontSize: fontSize,
      textStyle: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      alignment: alignment,
      child: children,
    );
  }

  Widget _getIcon(BuildContext context) {
    if (iconData != null) {
      return Icon(
        iconData,
        color: type.getTextColor(
          context,
          disabled: disabled,
          loading: loading,
          textColor: textColor,
        ),
      );
    } else {
      return icon!;
    }
  }

  Widget _textWidget({
    required bool iconIsInEdge,
    required Widget child,
  }) =>
      iconIsInEdge ? Expanded(child: child) : Flexible(child: child);
}
