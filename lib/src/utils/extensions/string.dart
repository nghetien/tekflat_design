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

  String get convertToSlug  {
    // Loại bỏ dấu và ký tự không phù hợp
    String slug = replaceAll(RegExp(r'[^a-zA-Z0-9\s-]'), '');

    // Chuyển thành chữ thường
    slug = slug.toLowerCase();

    // Thay thế khoảng trắng bằng dấu gạch ngang
    slug = slug.replaceAll(RegExp(r'\s+'), '-');

    // Loại bỏ các dấu gạch ngang liên tiếp
    slug = slug.replaceAll(RegExp(r'(-)+'), '-');

    return slug;
  }

  String get toLowerCaseNonAccentVietnamese {
    String str = this;
    str = str.toLowerCase();
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), "a");
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), "e");
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), "i");
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), "o");
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), "u");
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), "y");
    str = str.replaceAll(RegExp(r'đ'), "d");
    str = str.replaceAll(RegExp(r'[\u0300\u0301\u0303\u0309\u0323]'), "");
    str = str.replaceAll(RegExp(r'[\u02C6\u0306\u031B]'), "");
    return str;
  }

  String get toNonAccentVietnamese {
    String str = this;
    str = str.replaceAll(RegExp(r'[AÁÀÃẠÂẤẦẪẬĂẮẰẴẶ]'), "A");
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), "a");
    str = str.replaceAll(RegExp(r'[EÉÈẼẸÊẾỀỄỆ]'), "E");
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), "e");
    str = str.replaceAll(RegExp(r'[IÍÌĨỊ]'), "I");
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), "i");
    str = str.replaceAll(RegExp(r'[OÓÒÕỌÔỐỒỖỘƠỚỜỠỢ]'), "O");
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), "o");
    str = str.replaceAll(RegExp(r'[UÚÙŨỤƯỨỪỮỰ]'), "U");
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), "u");
    str = str.replaceAll(RegExp(r'[YÝỲỸỴ]'), "Y");
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), "y");
    str = str.replaceAll(RegExp(r'Đ'), "D");
    str = str.replaceAll(RegExp(r'đ'), "d");
    str = str.replaceAll(RegExp(r'[\u0300\u0301\u0303\u0309\u0323]'), "");
    str = str.replaceAll(RegExp(r'[\u02C6\u0306\u031B]'), "");
    return str;
  }
}
