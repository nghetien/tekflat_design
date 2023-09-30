part of 'bottom_sheet.dart';

class TagBottomSheet1Widget extends StatelessWidget {
  const TagBottomSheet1Widget({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.alignment,
  });

  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          EdgeInsets.only(
            top: TekSpacings().p8,
          ),
      padding: padding,
      alignment: alignment ?? Alignment.topCenter,
      width: width ?? 42,
      height: height ?? 4,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        color: backgroundColor ?? TekColors().greyOpacity06,
      ),
    );
  }
}

class TagBottomSheet2Widget extends StatelessWidget {
  const TagBottomSheet2Widget({
    super.key,
    this.title,
    this.titleType,
    this.titleFontWeight,
    this.backBtnIsRight = true,
    this.haveDivider = true,
  });

  final String? title;
  final TekTypographyType? titleType;
  final FontWeight? titleFontWeight;
  final bool backBtnIsRight;
  final bool haveDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(TekSpacings().mainSpacing),
          child: Stack(
            children: [
              Align(
                child: TekTypography(
                  text: title ?? '',
                  type: titleType ?? TekTypographyType.level4,
                  fontWeight: titleFontWeight ?? FontWeight.w500,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: backBtnIsRight ? 0 : null,
                left: backBtnIsRight ? null : 0,
                child: TekButtonInkwell(
                  onPressed: () => popNavigatorMultiPlatform(context),
                  child: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
        ),
        if (haveDivider) const TekDivider(),
      ],
    );
  }
}
