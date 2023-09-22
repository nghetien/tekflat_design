part of 'tags.dart';

class TekDynamicTag extends StatelessWidget {
  const TekDynamicTag({
    Key? key,
    this.textContent,
    this.content,
    required this.whenClose,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.backgroundColorIcon,
    this.iconPadding,
  }) : super(key: key);

  final String? textContent;
  final Widget? content;
  final VoidCallback whenClose;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColorIcon;
  final EdgeInsets? iconPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: TekSpacings().p8,
            vertical: TekSpacings().p4,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? TekColors().greyOpacity01,
        borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: content != null ? content! : Text(textContent ?? ''),
          ),
          TekHSpace.p8,
          Container(
            padding: iconPadding ?? EdgeInsets.all(2.scaleSpacing),
            decoration: BoxDecoration(
              color: backgroundColorIcon ?? TekColors().greyOpacity04,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: whenClose,
              child: icon ??
                  Icon(
                    Icons.close,
                    size: iconSize ?? TekIconSizes().s14,
                    color: iconColor,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
