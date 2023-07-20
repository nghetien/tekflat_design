import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekLineDash extends StatelessWidget {
  const TekLineDash({
    Key? key,
    this.height = TekBorders.thin,
    this.color,
    this.dashWidth = 5,
  }) : super(key: key);

  final double height;
  final Color? color;
  final double dashWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(
            dashCount,
            (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color ?? TekColors.greyOpacity04),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
