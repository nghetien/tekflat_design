import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TekPhoneFormatter {
  const TekPhoneFormatter._();

  static final MaskTextInputFormatter phoneInputFormatter = MaskTextInputFormatter(
    mask: "@!## ### ###",
    filter: {
      "@": RegExp(r'0'),
      "!": RegExp(r'[357-9]'),
      "#": RegExp(r'\d'),
    },
    type: MaskAutoCompletionType.lazy,
  );

  static final TextInputFormatter phoneInputFormatter2 = FilteringTextInputFormatter.allow(
    RegExp(r'[\d+]'),
  );
}
