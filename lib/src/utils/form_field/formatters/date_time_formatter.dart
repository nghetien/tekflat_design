import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TekDateTimeFormatter {
  TekDateTimeFormatter._privateConstructor();

  static final TekDateTimeFormatter _instance = TekDateTimeFormatter._privateConstructor();

  factory TekDateTimeFormatter() => _instance;

  String _dateFormatter = "dd/MM/yyyy";
  String _timeFormatter = "HH:mm";
  String _dateTimeFormatter = "dd/MM/yyyy HH:mm";

  String get dateFormatter => _dateFormatter;

  String get timeFormatter => _timeFormatter;

  String get dateTimeFormatter => _dateTimeFormatter;

  void setDateFormatter(String value) => _dateFormatter = value;

  void setTimeFormatter(String value) => _timeFormatter = value;

  void setDateTimeFormatter(String value) => _dateTimeFormatter = value;

  TextInputFormatter _dateInputFormatter = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  TextInputFormatter _timeInputFormatter = MaskTextInputFormatter(
    mask: "##:##",
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  TextInputFormatter _dateTimeInputFormatter = MaskTextInputFormatter(
    mask: "##/##/#### ##:##",
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  TextInputFormatter get dateInputFormatter => _dateInputFormatter;

  TextInputFormatter get timeInputFormatter => _timeInputFormatter;

  TextInputFormatter get dateTimeInputFormatter => _dateTimeInputFormatter;

  void setDateInputFormatter(TextInputFormatter value) => _dateInputFormatter = value;

  void setTimeInputFormatter(TextInputFormatter value) => _timeInputFormatter = value;

  void setDateTimeInputFormatter(TextInputFormatter value) => _dateTimeInputFormatter = value;
}
