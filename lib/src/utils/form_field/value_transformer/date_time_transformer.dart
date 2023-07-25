import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TekDateTimeTransformer {
  const TekDateTimeTransformer._();

  static DateTime? parse(
    String? value, {
    String? formatter,
  }) {
    if(value == null || value.isEmpty) return null;
    try {
      if (formatter != null) return DateFormat(formatter).parse(value);
      return DateTime.parse(value);
    } catch (e) {
      return null;
    }
  }

  static TimeOfDay? timeOfDay(String str) {
    try {
      final List<String> split = str.split(':');
      final int hour = int.parse(split[0]);
      final int minute = int.parse(split[1]);
      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null;
    }
  }
}
