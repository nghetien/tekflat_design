extension TekMapStringToDynamicEx on Map<String, dynamic> {
  Map<String, dynamic> get clearNullValue => this
    ..removeWhere(
      (key, value) => value == null || (value is String && value.isEmpty),
    );
}
