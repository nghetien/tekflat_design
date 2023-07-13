import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TekWrapScrollHorizontal extends StatelessWidget {
  const TekWrapScrollHorizontal({
    Key? key,
    required this.controller,
    this.physics,
    required this.child,
  }) : super(key: key);

  final ScrollController controller;
  final ScrollPhysics? physics;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          final scroll = controller.offset + pointerSignal.scrollDelta.dy;
          if (scroll < 0) {
            controller.jumpTo(0);
          } else if (scroll > controller.position.maxScrollExtent) {
            controller.jumpTo(controller.position.maxScrollExtent);
          } else {
            controller.jumpTo(scroll);
          }
        }
      },
      child: SingleChildScrollView(
        physics: physics ?? const ClampingScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: child,
      ),
    );
  }
}
