import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TekNumberFormatter {
  TekNumberFormatter._privateConstructor();

  static final TekNumberFormatter _instance = TekNumberFormatter._privateConstructor();

  factory TekNumberFormatter() => _instance;

  static final TextInputFormatter digitsOnly = FilteringTextInputFormatter.digitsOnly;

  static final digitsWithDotAndCommaAndDash = FilteringTextInputFormatter.allow(RegExp(r'[\d.,-]'));

  static final digitsWithDotAndDash = FilteringTextInputFormatter.allow(RegExp(r'[\d.-]'));

  static final digitsWithDot = FilteringTextInputFormatter.allow(RegExp(r'[\d.]'));

  static final digitsWithDotAndComma = FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'));

  static final TextInputFormatter currency = _FormatTextToCurrency();

  static String truncateNumberToString(dynamic number) {
    if(number == null) return '0';
    final f = NumberFormat("###,###.###", "tr_TR");
    return f.format(number).replaceAll(',', '*').replaceAll('.', ',').replaceAll('*', '.');
  }
}

class _FormatTextToCurrency implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '0',
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    if (newValue.text == '-') return newValue;

    if (newValue.text.length >= 25) return oldValue;

    if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      String handleText = newValue.text
          .replaceAll(',', '')
          .replaceFirst('.', '+')
          .replaceAll('.', '')
          .replaceAll('+', '.')
          .trim();
      final splitDotNewText = handleText.split('.');
      if (splitDotNewText[0].isEmpty) splitDotNewText[0] = '0';
      splitDotNewText[0] = (splitDotNewText[0][0] == '-' ? '-' : '') +
          TekNumberFormatter.truncateNumberToString(
            int.parse(
              splitDotNewText[0].replaceAll("-", "").trim(),
            ),
          );
      String newString = splitDotNewText[0];
      bool isThreeZero = false;
      if (splitDotNewText.length >= 2 && splitDotNewText[1].length >= 3) {
        final textAfterDot = splitDotNewText[1].substring(0, 3);
        if (textAfterDot == '000') {
          isThreeZero = true;
        }
        splitDotNewText[1] = double.parse(
          '0.$textAfterDot',
        ).toString().split('.')[1];
      }
      if (splitDotNewText.length >= 2) {
        newString = '${splitDotNewText[0]}.${splitDotNewText[1]}';
      }
      if (isThreeZero) newString = splitDotNewText[0];
      final int newSelection = newString.length - selectionIndexFromTheRight;
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newSelection > 0 ? newSelection : newValue.selection.end,
        ),
      );
    }
    return newValue;
  }
}
