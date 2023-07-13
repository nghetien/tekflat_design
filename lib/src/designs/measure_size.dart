import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef TekOnWidgetSizeChange = void Function(Size size);

class TekMeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final TekOnWidgetSizeChange onChange;

  TekMeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
  }
}

class TekMeasureSize extends SingleChildRenderObjectWidget {
  final TekOnWidgetSizeChange onChange;

  const TekMeasureSize({required this.onChange, required Widget child, Key? key}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return TekMeasureSizeRenderObject(onChange);
  }
}