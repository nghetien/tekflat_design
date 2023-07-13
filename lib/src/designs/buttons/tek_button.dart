part of 'buttons.dart';

enum TekButtonSize {
  large(42),
  medium(35),
  small(26);

  const TekButtonSize(this.height);

  final double height;

  static double getPaddingHorizontal(TekButtonSize? size) {
    if (size == null) return TekPaddings().mainPadding;
    switch (size) {
      case TekButtonSize.large:
        return TekPaddings().mainPadding;
      case TekButtonSize.medium:
        return TekPaddings().p8;
      case TekButtonSize.small:
        return TekPaddings().p8;
      default:
        return TekPaddings().mainPadding;
    }
  }

  static double getPaddingVertical(TekButtonSize? size) {
    if (size == null) return TekPaddings().p8;
    return 0;
  }

  static double getWidthLoading(TekButtonSize? size) {
    if (size == null) return 20;
    switch (size) {
      case TekButtonSize.large:
        return 14;
      case TekButtonSize.medium:
        return 12;
      case TekButtonSize.small:
        return 10;
      default:
        return 20;
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
          textColor: Colors.white,
          outlinedBorder: null,
        );
      case TekButtonType.none:
        return TekButtonTypeStyle(
          backgroundColor: Colors.transparent,
          textColor: context?.theme.textTheme.bodyMedium?.color,
          outlinedBorder: null,
        );
    }
  }
}

class TekButton extends StatelessWidget {
  const TekButton({
    Key? key,
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

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: height ?? size?.height,
        width: width,
        decoration: BoxDecoration(boxShadow: boxShadow),
        child: ElevatedButton(
          key: key,
          onPressed: () {
            if (disabled || loading) return;
            onPressed();
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
                  horizontal: TekButtonSize.getPaddingHorizontal(size),
                  vertical: TekButtonSize.getPaddingVertical(size),
                ),
            child: _getContent(context),
          ),
        ),
      );

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
            TekTextStyles.body.copyWith(
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

    if (loading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: TekButtonSize.getWidthLoading(size),
            width: TekButtonSize.getWidthLoading(size),
            child: CircularProgressIndicator(
              strokeWidth: TekBorders.thin,
              color: type.getTextColor(
                context,
                disabled: disabled,
                loading: loading,
                textColor: textColor,
              ),
            ),
          ),
          if (content != null)
            Padding(
              padding: EdgeInsets.only(
                left: TekButtonSize.getPaddingHorizontal(size),
              ),
              child: content,
            )
        ],
      );
    }
    return content ?? const SizedBox.shrink();
  }
}
