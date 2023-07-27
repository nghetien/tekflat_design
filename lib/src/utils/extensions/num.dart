import 'package:intl/intl.dart';
import 'package:tekflat_design/src/styles/styles.dart';

extension TekNumEx on num {
  double get scaleFontSize => this * TekFontSizes().scale;

  double get scaleIconSize => this * TekIconSizes().scale;

  double get scaleSpacing => this * TekSpacings().scale;

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

  String get truncateNumberToString {
    final f = NumberFormat("###,###.###", "tr_TR");
    return f.format(this).replaceAll(',', '*').replaceAll('.', ',').replaceAll('*', '.');
  }
}
