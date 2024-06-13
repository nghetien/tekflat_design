import 'package:flutter/material.dart';

import 'typography.dart';

class TekGradientText extends StatelessWidget {
  const TekGradientText({
    super.key,
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
    this.blendMode,
    required this.gradient,
    this.rectLeft,
    this.rectTop,
  });

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

  final BlendMode? blendMode;
  final Gradient gradient;
  final double? rectLeft;
  final double? rectTop;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: blendMode ?? BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient.createShader(
            Rect.fromLTWH(rectLeft ?? 0, rectTop ?? 0, bounds.width, bounds.height),
          ),
      child: TekTypography(
        text: text,
        type: type,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
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
      ),
    );
  }
}
