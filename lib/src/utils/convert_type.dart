class TekConvertType {
  const TekConvertType._();

  static T? convertTo<T>(dynamic value) {
    if (value == null) return null;
    if (value is T) return value;
    if (value is String && value.isEmpty) return null;
    try {
      return value as T?;
    } catch (e) {
      return null;
    }
  }

  static List<T>? convertToList<T>(dynamic value) {
    if (value == null) return null;
    if (value is! List) return null;
    try {
      return value.cast<T>();
    } catch (e) {
      return null;
    }
  }
}
