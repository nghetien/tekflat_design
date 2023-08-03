class TekNumberTransformer {
  const TekNumberTransformer._();

  static num? currencyToNumber(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value == '-') return 0;
    return num.tryParse(value.replaceAll(',', '').trim());
  }
}
