import 'package:flutter/services.dart';

class TekTextFormatter {
  TekTextFormatter._privateConstructor();

  static final TekTextFormatter _instance = TekTextFormatter._privateConstructor();

  factory TekTextFormatter() => _instance;

  static final TextInputFormatter charactersAndDigitsOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

  static final TextInputFormatter wordsOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[\wàáảãạèéẻẽẹìíỉĩịòóỏõọùúủũụỳýỷỹỵỨỪỬỮỰÚÙẦẤẨẪẬẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌ ]'));
}
