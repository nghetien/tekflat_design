import '../logger.dart';

class TekDynamicExtension {
  const TekDynamicExtension._();

  static bool ableParseToInt(dynamic value) {
    if (value is int) return true;
    try {
      int.parse(value);
      return true;
    } catch (e) {
      TekLogger.errorLog("canParseToInt: $e");
      return false;
    }
  }

  static bool isPositiveNumber(dynamic value) {
    if (!ableParseToInt(value)) return false;
    if (value is int) return value > 0;
    try {
      return int.parse(value) > 0;
    } catch (e) {
      TekLogger.errorLog("isPositiveNumber: $e");
      return false;
    }
  }
}
