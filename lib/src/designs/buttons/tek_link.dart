part of 'buttons.dart';

enum TekLinkType {
  color,
  noColor;

  Color getColor(BuildContext context) =>
      this == TekLinkType.color ? TekColors().blue : TekColors().grey;
}

enum TekLinkSize {
  small,
  medium;

  double get space => this == TekLinkSize.small ? TekSpacings().p4 : TekSpacings().p6;

  double get iconSize => this == TekLinkSize.small ? TekIconSizes().s18 : TekIconSizes().s24;
}

class TekLink extends StatelessWidget {
  const TekLink({
    super.key,

    /// Size
    this.size = TekLinkSize.small,
    this.type = TekLinkType.color,

    /// Content
    this.text,
    this.iconData,
    this.icon,
    this.child,

    /// Action
    this.onPressed,

    /// Animation
    this.cursor = SystemMouseCursors.click,

    /// State
    this.disabled = false,

    /// Style
    this.iconColor,
    this.iconSize,
    this.maxLines,
    this.textStyle,
    this.textSize,
    this.textColor,
    this.iconIsRight = false,
    this.fontWeight,
    this.decoration,
  });

  /// Size
  final TekLinkSize size;
  final TekLinkType type;

  /// Content
  final String? text;
  final IconData? iconData;
  final Widget? icon;
  final Widget? child;

  /// Action
  final VoidCallback? onPressed;

  /// Animation
  final MouseCursor cursor;

  /// State
  final bool disabled;

  /// Style
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? textStyle;
  final int? maxLines;
  final Color? textColor;
  final double? textSize;
  final bool iconIsRight;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          onPressed?.call();
        }
      },
      child: MouseRegion(
        cursor: disabled ? MouseCursor.uncontrolled : cursor,
        child: _getContent(context),
      ),
    );
  }

  Widget? _getIcon(BuildContext context) {
    if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize ?? size.iconSize,
        color: disabled ? context.theme.disabledColor : iconColor ?? type.getColor(context),
      );
    } else if (icon != null) {
      return icon;
    } else {
      return null;
    }
  }

  Widget _getContent(BuildContext context) {
    Widget? content;
    if (child != null) {
      content = child!;
    } else if (text != null) {
      late TextStyle sizeTextStyle;
      if (size == TekLinkSize.small) {
        sizeTextStyle = TekTextStyles().label;
      } else {
        sizeTextStyle = TekTextStyles().body;
      }

      content = Text(
        text ?? '',
        textAlign: TextAlign.center,
        maxLines: maxLines,
        style: textStyle ??
            sizeTextStyle.copyWith(
              color: disabled ? context.theme.disabledColor : textColor ?? type.getColor(context),
              height: 0,
              fontWeight: fontWeight,
              decoration: decoration,
            ),
      );
    }

    final Widget? icon = _getIcon(context);
    if (iconIsRight) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (content != null) content,
          if (icon != null) TekHSpace(size.space),
          if (icon != null) icon,
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon,
        if (icon != null) TekHSpace(size.space),
        if (content != null) content,
      ],
    );
  }
}
