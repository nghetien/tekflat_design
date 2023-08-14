import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './tek_validator_mess_error.dart';

class TekDateTimeValidator {
  const TekDateTimeValidator._();

  static bool isValidDate({
    required int year,
    required int month,
    required int day,
  }) {
    try {
      DateTime(year, month, day);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidYear({
    required int year,
    int? month,
    int? day,
  }) {
    try {
      if (month != null && day != null) {
        DateTime(year, month, day);
      } else if (month != null) {
        DateTime(year, month);
      } else {
        DateTime(year);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidMonth({
    required int month,
    int? day,
  }) {
    try {
      final DateTime now = DateTime.now();
      if (day != null) {
        DateTime(now.year, month, day);
      } else {
        DateTime(now.year, month);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidDay({
    required int day,
  }) {
    try {
      final DateTime now = DateTime.now();
      DateTime(now.year, now.month, day);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidHour({
    required int hour,
  }) {
    try {
      final DateTime now = DateTime.now();
      DateTime(now.year, now.month, now.day, hour);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidMinute({
    required int minute,
  }) {
    try {
      final DateTime now = DateTime.now();
      DateTime(now.year, now.month, now.day, now.hour, minute);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidTime(int hour, int minute) {
    try {
      final DateTime now = DateTime.now();
      DateTime(now.year, now.month, now.day, hour, minute);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isDateTime(String str, {
    String? validator,
  }) {
    try {
      if (validator != null) {
        DateFormat(validator).parse(str);
        return true;
      }
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isTimeOfDay(String str) {
    try {
      final List<String> split = str.split(':');
      final int hour = int.parse(split[0]);
      final int minute = int.parse(split[1]);
      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  static FormFieldValidator<DateTime> dateTime({String? errorText}) => (valueCandidate) =>
      valueCandidate != null ? errorText ?? TekFormValidatorMessageError().dateTime : null;

  static FormFieldValidator<DateTime> timeOfDay({String? errorText}) => (valueCandidate) =>
      valueCandidate != null ? errorText ?? TekFormValidatorMessageError().timeOfDay : null;
}
