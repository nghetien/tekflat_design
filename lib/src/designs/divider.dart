import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekDivider extends StatelessWidget {
  const TekDivider({
    this.height = 2,
    this.border,
    this.borderRadius,
    this.color,
    Key? key,
  }) : super(key: key);

  final double height;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color ?? TekColors.greyOpacity01,
          borderRadius: borderRadius ?? TekCorners.cornerBorder8,
          border: border,
        ),
      ),
    );
  }
}
