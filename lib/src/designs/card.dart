import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';
import 'package:tekflat_design/src/utils/utils.dart';

class TekCard extends StatelessWidget {
  const TekCard({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.alignment,
    this.shape,
    this.decoration,
  }) : super(key: key);

  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Alignment? alignment;
  final BoxShape? shape;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding ?? EdgeInsets.all(TekSpacings().mainSpacing),
        alignment: alignment,
        decoration: decoration ?? BoxDecoration(
          color: backgroundColor ?? context.theme.cardColor,
          borderRadius:
              shape == BoxShape.circle ? null : (borderRadius ?? TekCorners().mainCornerBorder),
          border: border ??
              Border.all(
                color: Colors.transparent,
                width: 0,
              ),
          boxShadow: boxShadow,
          shape: shape ?? BoxShape.rectangle,
        ),
        child: child,
      );
}
