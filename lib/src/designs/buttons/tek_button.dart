part of 'buttons.dart';

enum TekButtonSize {
  large(48),
  medium(40),
  small(32);

  const TekButtonSize(this.height);

  final double height;

  static double getPaddingVertical(TekButtonSize? size) {
    if (size == null) return 8;
    return 0;
  }

  static double getSpaceLoading(TekButtonSize? size) {
    switch (size) {
      case TekButtonSize.large:
        return 6;
      case TekButtonSize.medium:
        return 4;
      case TekButtonSize.small:
        return 2;
      default:
        return 2;
    }
  }

  static double getSizeLoading(TekButtonSize? size) {
    switch (size) {
      case TekButtonSize.large:
        return 16;
      case TekButtonSize.medium:
        return 14;
      case TekButtonSize.small:
        return 12;
      default:
        return 14;
    }
  }

  static double getIconSize(TekButtonSize? size) {
    switch (size) {
      case TekButtonSize.large:
        return TekIconSizes().s20;
      case TekButtonSize.medium:
        return TekIconSizes().s18;
      case TekButtonSize.small:
        return TekIconSizes().s14;
      default:
        return TekIconSizes().s18;
    }
  }

  static TextStyle getTextStyle(TekButtonSize? size) {
    switch (size) {
      case TekButtonSize.large:
        return TekTextStyles.titleMedium;
      case TekButtonSize.medium:
        return TekTextStyles.body;
      case TekButtonSize.small:
        return TekTextStyles.label;
      default:
        return TekTextStyles.body;
    }
  }
}

class TekButtonTypeStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final OutlinedBorder? outlinedBorder;

  const TekButtonTypeStyle({
    this.backgroundColor,
    this.textColor,
    this.outlinedBorder,
  });
}

enum TekButtonType {
  primary,
  outline,
  danger,
  warning,
  success,
  info,
  ghost,
  themeGhost,
  none;

  Color? getTextColor(
    BuildContext context, {
    bool disabled = false,
    bool loading = false,
    Color? textColor,
  }) {
    return (disabled || loading)
        ? (textColor ?? style(context: context).textColor)?.withOpacity(0.4)
        : (textColor ?? style(context: context).textColor);
  }

  TekButtonTypeStyle style({BuildContext? context}) {
    switch (this) {
      case TekButtonType.primary:
        return TekButtonTypeStyle(
          backgroundColor: TekColors().primary,
          textColor: Colors.white,
          outlinedBorder: null,
        );
      case TekButtonType.outline:
        return TekButtonTypeStyle(
          backgroundColor: Colors.transparent,
          textColor: context?.theme.textTheme.bodyMedium?.color ?? TekColors.grey,
          outlinedBorder: RoundedRectangleBorder(
            side: BorderSide(
              color: context?.theme.textTheme.bodyMedium?.color ?? TekColors.grey,
              width: TekBorders.thin,
            ),
            borderRadius: TekCorners().mainCornerBorder,
          ),
        );
      case TekButtonType.danger:
        return const TekButtonTypeStyle(
          backgroundColor: TekColors.red,
          textColor: Colors.white,
          outlinedBorder: null,
        );
      case TekButtonType.warning:
        return const TekButtonTypeStyle(
          backgroundColor: TekColors.yellow,
          textColor: Colors.white,
          outlinedBorder: null,
        );
      case TekButtonType.success:
        return const TekButtonTypeStyle(
          backgroundColor: TekColors.green,
          textColor: Colors.white,
          outlinedBorder: null,
        );
      case TekButtonType.info:
        return const TekButtonTypeStyle(
          backgroundColor: TekColors.blueLight,
          textColor: TekColors.white,
          outlinedBorder: null,
        );
      case TekButtonType.none:
        return TekButtonTypeStyle(
          backgroundColor: Colors.transparent,
          textColor: context?.theme.textTheme.bodyMedium?.color,
          outlinedBorder: null,
        );
      case TekButtonType.ghost:
        return TekButtonTypeStyle(
          backgroundColor: Colors.transparent,
          textColor: TekColors.grey,
          outlinedBorder: RoundedRectangleBorder(
            side: const BorderSide(
              color: TekColors.grey,
              width: TekBorders.thin,
            ),
            borderRadius: TekCorners().mainCornerBorder,
          ),
        );
      case TekButtonType.themeGhost:
        return TekButtonTypeStyle(
          backgroundColor: context?.theme.inputDecorationTheme.fillColor,
          textColor: TekColors().primary,
          outlinedBorder: null,
        );
    }
  }
}

class TekButton extends StatelessWidget {
  const TekButton({
    Key? key,

    /// Button
    this.size,
    this.type = TekButtonType.none,

    /// Action
    this.onPressed,
    this.onHover,

    /// State
    this.disabled = false,
    this.loading = false,

    /// Content
    this.text,
    this.child,
    this.icon,
    this.iconData,
    this.iconIsRight = false,

    /// Size
    this.width,
    this.height,

    /// Style
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
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  /// Button
  final TekButtonSize? size;
  final TekButtonType type;

  /// Action
  final VoidCallback? onPressed;
  final Function(bool?)? onHover;

  /// State
  final bool disabled;
  final bool loading;

  /// Content
  final String? text;
  final Widget? child;
  final Widget? icon;
  final IconData? iconData;
  final bool iconIsRight;

  /// Size
  final double? width;
  final double? height;

  /// Style
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
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: height ?? size?.height,
        width: width,
        decoration: BoxDecoration(boxShadow: boxShadow),
        child: ElevatedButton(
          key: key,
          onHover: (value) {
            if (disabled || loading) return;
            onHover?.call(value);
          },
          onPressed: () {
            if (disabled || loading) return;
            onPressed?.call();
          },
          style: ElevatedButton.styleFrom(
            alignment: alignment,
            backgroundColor: (disabled || loading)
                ? (background ?? type.style().backgroundColor)?.withOpacity(0.4)
                : (background ?? type.style().backgroundColor),
            shape: shape ??
                type.style(context: context).outlinedBorder?.copyWith(
                      side: BorderSide(
                        color: ((disabled || loading)
                                ? type
                                    .style(context: context)
                                    .outlinedBorder
                                    ?.side
                                    .color
                                    .withOpacity(0)
                                : type.style(context: context).outlinedBorder?.side.color) ??
                            Colors.transparent,
                      ),
                    ),
            padding: EdgeInsets.zero,
            shadowColor: shadowColor,
            elevation: elevation ?? 0,
            minimumSize: Size.zero,
            foregroundColor: hoverColor,
            splashFactory: splashFactory,
            enabledMouseCursor:
                (disabled || loading) ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
          ),
          child: Container(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: TekSpacings().mainSpacing,
                  vertical:  TekButtonSize.getPaddingVertical(size),
                ),
            child: _getContent(context),
          ),
        ),
      );

  Widget? _getIcon(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: TekButtonSize.getSizeLoading(size),
        width: TekButtonSize.getSizeLoading(size),
        child: CircularProgressIndicator(
          strokeWidth: TekBorders.thin,
          color: type.getTextColor(
            context,
            disabled: disabled,
            loading: loading,
            textColor: textColor,
          ),
        ),
      );
    } else if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize ?? TekButtonSize.getIconSize(size),
        color: iconColor ?? type.getTextColor(
          context,
          disabled: disabled,
          loading: loading,
          textColor: textColor,
        ),
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
      content = Text(
        text!,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        style: textStyle ??
            TekButtonSize.getTextStyle(size).copyWith(
              color: type.getTextColor(
                context,
                disabled: disabled,
                loading: loading,
                textColor: textColor,
              ),
              height: 0,
              fontSize: fontSize,
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
          if (icon != null) TekHSpace(TekButtonSize.getSpaceLoading(size)),
          if (icon != null) icon,
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon,
        if (icon != null) TekHSpace(TekButtonSize.getSpaceLoading(size)),
        if (content != null) content,
      ],
    );
  }
}
