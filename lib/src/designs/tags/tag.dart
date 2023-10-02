part of 'tags.dart';

class TekTags {
  const TekTags._();

  static Widget success(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    bool isOutlined = false,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors().green,
        isOutlined: isOutlined,
      );

  static Widget failure(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    bool isOutlined = false,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors().red,
        isOutlined: isOutlined,
      );

  static Widget warning(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    bool isOutlined = false,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors().yellow,
        isOutlined: isOutlined,
      );

  static Widget info(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    bool isOutlined = false,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors().blue,
        isOutlined: isOutlined,
      );

  static Widget draft(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    bool isOutlined = false,
  }) =>
      tag(
        value,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        textStyle: textStyle,
        color: TekColors().grey,
        isOutlined: isOutlined,
      );

  static Widget tag(
    String value, {
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    Color? color,
    bool isOutlined = false,
  }) =>
      !isOutlined
          ? Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
              ),
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: 6.scaleSpacing,
                    vertical: 2.scaleSpacing,
                  ),
              child: Text(
                value,
                style: textStyle ??
                    TekTextStyles().label.copyWith(
                      color: TekColors().white,
                      height: 0,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: color?.withOpacity(0.1),
                borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
                border: Border.all(
                  color: color ?? TekColors().grey,
                  width: TekBorders.thin,
                ),
              ),
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: 6.scaleSpacing,
                    vertical: 2.scaleSpacing,
                  ),
              child: Text(
                value,
                style: textStyle ??
                    TekTextStyles().label.copyWith(
                      color: color,
                      height: 0,
                    ),
                textAlign: TextAlign.center,
              ),
            );
}
