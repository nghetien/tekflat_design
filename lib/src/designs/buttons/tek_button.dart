part of 'buttons.dart';

enum TekButtonSize {
  extraLarge,
  large,
  medium,
  small;

  const TekButtonSize();

  double get height {
    switch (this) {
      case extraLarge:
        return 56;
      case large:
        return 48;
      case medium:
        return 40;
      case small:
        return 32;
    }
  }

  double get spacing {
    switch (this) {
      case extraLarge:
        return 12.scaleSpacing;
      case large:
        return 10.scaleSpacing;
      case medium:
        return 8.scaleSpacing;
      case small:
        return 6.scaleSpacing;
    }
  }

  double get loadingSize {
    switch (this) {
      case extraLarge:
        return 14.scaleFontSize;
      case large:
        return 13.scaleFontSize;
      case medium:
        return 12.scaleFontSize;
      case small:
        return 10.scaleFontSize;
    }
  }

  double get iconSize {
    switch (this) {
      case extraLarge:
        return 20.scaleFontSize;
      case large:
        return 18.scaleFontSize;
      case medium:
        return 18.scaleFontSize;
      case small:
        return 14.scaleFontSize;
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case extraLarge:
        return TekTextStyles.titleMedium;
      case large:
        return TekTextStyles.body;
      case medium:
        return TekTextStyles.body;
      case small:
        return TekTextStyles.label;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case extraLarge:
        return EdgeInsets.symmetric(horizontal: 20.scaleSpacing);
      case large:
        return EdgeInsets.symmetric(horizontal: 18.scaleSpacing);
      case medium:
        return EdgeInsets.symmetric(horizontal: 16.scaleSpacing);
      case small:
        return EdgeInsets.symmetric(horizontal: 14.scaleSpacing);
    }
  }
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

  Color? getTextColor({
    required BuildContext context,
    Color? customizeColor,
    bool disabled = false,
    bool loading = false,
  }) {
    if (customizeColor != null) {
      return (disabled || loading) ? customizeColor.withOpacity(0.4) : customizeColor;
    }
    late Color? textColor;
    switch (this) {
      case TekButtonType.primary:
        textColor = TekColors.white;
        break;
      case TekButtonType.outline:
        textColor = TekColors().primary;
        break;
      case TekButtonType.danger:
        textColor = TekColors.white;
        break;
      case TekButtonType.warning:
        textColor = TekColors.white;
        break;
      case TekButtonType.success:
        textColor = TekColors.white;
        break;
      case TekButtonType.info:
        textColor = TekColors.white;
        break;
      case TekButtonType.none:
        textColor = context.theme.textTheme.titleMedium?.color;
        break;
      case TekButtonType.ghost:
        textColor = TekColors.grey;
        break;
      case TekButtonType.themeGhost:
        textColor = TekColors().primary;
        break;
    }
    return (disabled || loading) ? textColor?.withOpacity(0.4) : textColor;
  }

  Color? getBackgroundColor({
    required BuildContext context,
    bool disabled = false,
    bool loading = false,
    Color? customizeColor,
  }) {
    if (customizeColor != null) {
      return (disabled || loading) ? customizeColor.withOpacity(0.4) : customizeColor;
    }
    late Color backgroundColor;
    switch (this) {
      case TekButtonType.primary:
        backgroundColor = TekColors().primary;
        break;
      case TekButtonType.outline:
        backgroundColor = Colors.transparent;
        break;
      case TekButtonType.danger:
        backgroundColor = TekColors.red;
        break;
      case TekButtonType.warning:
        backgroundColor = TekColors.yellow;
        break;
      case TekButtonType.success:
        backgroundColor = TekColors.green;
        break;
      case TekButtonType.info:
        backgroundColor = TekColors.blue;
        break;
      case TekButtonType.none:
        backgroundColor = Colors.transparent;
        break;
      case TekButtonType.ghost:
        backgroundColor = Colors.transparent;
        break;
      case TekButtonType.themeGhost:
        backgroundColor = context.theme.colorScheme.background;
        break;
    }
    return (disabled || loading)
        ? backgroundColor == Colors.transparent
            ? TekColors.greyOpacity01
            : backgroundColor.withOpacity(0.4)
        : backgroundColor;
  }

  RoundedRectangleBorder getOutlinedBorderDefault({
    bool disabled = false,
    bool loading = false,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? borderWidth,
  }) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: (disabled || loading)
            ? borderColor?.withOpacity(0.4) ?? Colors.transparent
            : borderColor ?? Colors.transparent,
        width: borderWidth ?? 0,
      ),
      borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
    );
  }

  OutlinedBorder? getOutlinedBorder({
    required BuildContext context,
    bool disabled = false,
    bool loading = false,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? borderWidth,
  }) {
    switch (this) {
      case TekButtonType.primary:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
      case TekButtonType.outline:
        final borderSizeColor = TekColors().primary;
        return RoundedRectangleBorder(
          side: BorderSide(
            color: (disabled || loading)
                ? borderSizeColor.withOpacity(0.4)
                : borderColor ?? borderSizeColor,
            width: borderWidth ?? TekBorders.thin,
          ),
          borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        );
      case TekButtonType.danger:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
      case TekButtonType.warning:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
      case TekButtonType.success:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
      case TekButtonType.info:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
      case TekButtonType.none:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
      case TekButtonType.ghost:
        const borderSizeColor = TekColors.grey;
        return RoundedRectangleBorder(
          side: BorderSide(
            color: (disabled || loading)
                ? borderSizeColor.withOpacity(0.4)
                : borderColor ?? borderSizeColor,
            width: borderWidth ?? TekBorders.thin,
          ),
          borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        );
      case TekButtonType.themeGhost:
        return getOutlinedBorderDefault(
          disabled: disabled,
          loading: loading,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
        );
    }
  }
}

class TekButton extends StatelessWidget {
  const TekButton({
    Key? key,

    /// Button
    this.size = TekButtonSize.medium,
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
    this.shadowColor,
    this.elevation,
    this.boxShadow,
    this.splashFactory,
    this.shape,
    this.textColor,
    this.fontSize,
    this.textStyle,
    this.textAlign,
    this.maxLines = 1,
    this.alignment,
    this.iconColor,
    this.iconSize,
    this.mainAxisAlignment,
    this.spaceBetweenIconAndText,
    this.fontWeight,
    this.mainAxisSize,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
  }) : super(key: key);

  /// Button
  final TekButtonSize size;
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
  final Color? shadowColor;
  final double? elevation;
  final InteractiveInkFeatureFactory? splashFactory;
  final List<BoxShadow>? boxShadow;
  final OutlinedBorder? shape;
  final Color? textColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int maxLines;
  final AlignmentGeometry? alignment;
  final double? iconSize;
  final Color? iconColor;
  final MainAxisAlignment? mainAxisAlignment;
  final double? spaceBetweenIconAndText;
  final FontWeight? fontWeight;
  final MainAxisSize? mainAxisSize;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: height ?? size.height,
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
            backgroundColor: type.getBackgroundColor(
              context: context,
              disabled: disabled,
              loading: loading,
              customizeColor: background,
            ),
            shape: shape ??
                type.getOutlinedBorder(
                  context: context,
                  disabled: disabled,
                  loading: loading,
                  borderColor: borderColor,
                  borderRadius: borderRadius,
                  borderWidth: borderWidth,
                ),
            padding: EdgeInsets.zero,
            shadowColor: shadowColor ?? Colors.transparent,
            elevation: elevation ?? 0,
            minimumSize: Size.zero,
            foregroundColor: hoverColor,
            splashFactory: splashFactory,
            enabledMouseCursor:
                (disabled || loading) ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
          ),
          child: Padding(
            padding: padding ?? size.padding,
            child: _getContent(context),
          ),
        ),
      );

  Widget? _getIcon(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: size.loadingSize,
        width: size.loadingSize,
        child: CircularProgressIndicator(
          strokeWidth: TekBorders.thin,
          color: type.getTextColor(
            context: context,
            disabled: disabled,
            loading: loading,
            customizeColor: textColor,
          ),
        ),
      );
    } else if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize ?? size.iconSize,
        color: iconColor ??
            type.getTextColor(
              context: context,
              disabled: disabled,
              loading: loading,
              customizeColor: textColor,
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
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            size.textStyle.copyWith(
              color: textColor ??
                  type.getTextColor(
                    context: context,
                    disabled: disabled,
                    loading: loading,
                    customizeColor: textColor,
                  ),
              height: 0,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
      );
    }

    final Widget? icon = _getIcon(context);
    if (iconIsRight) {
      return Row(
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          if (content != null) Flexible(child: content),
          if (icon != null && content != null) TekHSpace(spaceBetweenIconAndText ?? size.spacing),
          if (icon != null) icon,
        ],
      );
    }
    return Row(
      mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        if (icon != null) icon,
        if (icon != null && content != null) TekHSpace(spaceBetweenIconAndText ?? size.spacing),
        if (content != null) Flexible(child: content),
      ],
    );
  }
}
