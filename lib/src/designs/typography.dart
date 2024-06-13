import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

enum TekTypographyType {
  // Level 1
  display,
  displayMedium,
  displayBold,

  // Level 2
  headline,
  headlineMedium,
  headlineBold,

  // Level 3
  titleLarge,
  titleLargeMedium,
  titleLargeBold,

  // Level 4
  titleMedium,
  titleMediumMedium,
  titleMediumBold,

  // Level 5
  body,
  bodyMedium,
  bodyBold,

  // Level 6
  label,
  labelMedium,
  labelBold,
  ;

  TextStyle get textStyle {
    switch (this) {
      case TekTypographyType.display:
        return TekTextStyles().display.copyWith();
      case TekTypographyType.displayMedium:
        return TekTextStyles().display.copyWith(
              fontWeight: FontWeight.w500,
            );
      case TekTypographyType.displayBold:
        return TekTextStyles().display.copyWith(
              fontWeight: FontWeight.bold,
            );
      case TekTypographyType.headline:
        return TekTextStyles().headline;
      case TekTypographyType.headlineMedium:
        return TekTextStyles().headline.copyWith(
              fontWeight: FontWeight.w500,
            );
      case TekTypographyType.headlineBold:
        return TekTextStyles().headline.copyWith(
              fontWeight: FontWeight.bold,
            );
      case TekTypographyType.titleLarge:
        return TekTextStyles().titleLarge;
      case TekTypographyType.titleLargeMedium:
        return TekTextStyles().titleLarge.copyWith(
              fontWeight: FontWeight.w500,
            );
      case TekTypographyType.titleLargeBold:
        return TekTextStyles().titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            );
      case TekTypographyType.titleMedium:
        return TekTextStyles().titleMedium;
      case TekTypographyType.titleMediumMedium:
        return TekTextStyles().titleMedium.copyWith(
              fontWeight: FontWeight.w500,
            );
      case TekTypographyType.titleMediumBold:
        return TekTextStyles().titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            );
      case TekTypographyType.body:
        return TekTextStyles().body;
      case TekTypographyType.bodyMedium:
        return TekTextStyles().body.copyWith(
              fontWeight: FontWeight.w500,
            );
      case TekTypographyType.bodyBold:
        return TekTextStyles().body.copyWith(
              fontWeight: FontWeight.bold,
            );
      case TekTypographyType.label:
        return TekTextStyles().label;
      case TekTypographyType.labelMedium:
        return TekTextStyles().label.copyWith(
              fontWeight: FontWeight.w500,
            );
      case TekTypographyType.labelBold:
        return TekTextStyles().label.copyWith(
              fontWeight: FontWeight.bold,
            );
    }
  }
}

class TekTypography extends StatelessWidget {
  const TekTypography({
    Key? key,
    required this.text,
    this.type,
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
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : super(key: key);

  final String text;
  final TekTypographyType? type;
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
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: (type ?? TekTypographyType.body).textStyle.copyWith(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: color,
              height: height,
              overflow: overflow,
            ),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
}
