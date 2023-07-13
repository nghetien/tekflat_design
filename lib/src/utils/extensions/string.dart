import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../logger.dart';

extension TekStringEx on String {
  String get percentEncode {
    String input = Uri.encodeComponent(this);

    input = input.replaceAll('-', '%2D');
    input = input.replaceAll('_', '%5F');
    input = input.replaceAll('.', '%2E');
    input = input.replaceAll('!', '%21');
    input = input.replaceAll('~', '%7E');
    input = input.replaceAll('*', '%2A');
    input = input.replaceAll('\'', '%5C');
    input = input.replaceAll('(', '%28');
    input = input.replaceAll(')', '%29');

    return input;
  }

  DateTime get toDateTime => DateTime.parse(this);

  DateTime? get toDateTimeOrNull {
    try {
      return toDateTime;
    } catch (e) {
      return null;
    }
  }

  DateTime? toDateTimeWithFormat(String format) {
    if(isEmpty) return null;
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }

  TimeOfDay get toTODFromDT => TimeOfDay.fromDateTime(toDateTime);

  ValueKey get valueKey => ValueKey(this);

  String get capitalize => "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  TimeOfDay? get toTODFromTOD {
    try {
      final time = split(':');
      return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));
    } catch (e) {
      TekLogger.errorLog("convertTimeOfDay: $e");
      return null;
    }
  }
}
