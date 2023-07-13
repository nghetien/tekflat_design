import 'package:tekflat_design/src/utils/utils.dart';
import 'package:tekflat_design/src/styles/styles.dart';
import 'package:flutter/material.dart';

enum TekTypographyType {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6;

  TextStyle get textStyle {
    switch (this) {
      case TekTypographyType.h1:
        return TekTextStyles.display.copyWith(
          fontWeight: FontWeight.w500,
        );
      case TekTypographyType.h2:
        return TekTextStyles.headline.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 30.scaleSize,
        );
      case TekTypographyType.h3:
        return TekTextStyles.headline.copyWith(
          fontWeight: FontWeight.w500,
        );
      case TekTypographyType.h4:
        return TekTextStyles.titleLarge.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: TekFontSizes().s20,
        );
      case TekTypographyType.h5:
        return TekTextStyles.titleMedium.copyWith(
          fontWeight: FontWeight.w500,
        );
      case TekTypographyType.h6:
        return TekTextStyles.body.copyWith(
          fontWeight: FontWeight.w500,
        );
    }
  }
}

class TekTypography extends StatelessWidget {
  const TekTypography({
    Key? key,
    required this.text,
    required this.type,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.height,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : super(key: key);

  final String text;
  final TekTypographyType type;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final double? height;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) => Text(
    text,
        style: type.textStyle.copyWith(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          height: height,
        ),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
}
