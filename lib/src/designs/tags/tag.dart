part of 'tags.dart';

class TekTags {
  const TekTags._();

  static Widget success(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors.green,
      );

  static Widget failure(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors.red,
      );

  static Widget warning(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors.yellow,
      );

  static Widget info(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors.blueLight,
      );

  static Widget draft(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors.grey,
      );

  static Widget tag(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    Color? color,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: TekPaddings().p8,
              vertical: TekPaddings().p4,
            ),
        child: Text(
          value,
          style: textStyle ??
              TekTextStyles.body.copyWith(
                color: TekColors.white,
                height: 0,
              ),
          textAlign: TextAlign.center,
        ),
      );
}
