import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekBadge extends StatelessWidget {
  const TekBadge({
    Key? key,
    required this.child,
    this.count = 0,
    this.color,
    this.top,
    this.right,
  }) : super(key: key);

  final Widget child;
  final int count;
  final Color? color;
  final double? top;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child,
        if (count > 0)
          Positioned(
            top: top ?? -10,
            right: right ?? -10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color ?? TekColors().red,
                borderRadius: TekCorners.cornerBorder20,
              ),
              child: Text(
                count > 999 ? '999+' : count.toString(),
                style: TekTextStyles().label.copyWith(
                  color: TekColors().white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
