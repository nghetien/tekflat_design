import 'package:tekflat_design/src/responsive/responsive.dart';

extension TekNumEx on num {
  double get scaleSize => TekResponsiveConfig().scale * this;

  /// Example:
  /// 1.0 -> 1
  /// 2.0000 -> 2
  /// 3.01 -> 3.01
  num getMaxPrecision({int? maxDigits}) {
    if (round() == this) return round().toInt();
    if (maxDigits == null) return num.parse(toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), ""));
    return num.parse(
      toStringAsFixed(maxDigits).replaceAll(
        RegExp(r'([.]*0)(?!.*\d)'),
        "",
      ),
    );
  }
}
