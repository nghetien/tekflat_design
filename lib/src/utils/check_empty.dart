class TekEmpty {
  const TekEmpty._();

  static bool checkEmpty(dynamic value) {
    if (value is String && value.isEmpty) return true;
    if (value is List && value.isEmpty) return true;
    if (value is Map && value.isEmpty) return true;
    if (value is Set && value.isEmpty) return true;
    if (value is Iterable && value.isEmpty) return true;
    return value == null;
  }
}