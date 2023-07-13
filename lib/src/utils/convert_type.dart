class TekConvertType {
  const TekConvertType._();

  static T? convertTo<T>(dynamic value) {
    if(value == null) return null;
    if(value is T) return value;
    if(value is String && value.isEmpty) return null;
    try {
      return value as T?;
    } catch (e) {
      return null;
    }
  }
}
