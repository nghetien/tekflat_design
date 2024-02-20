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
    str = str.replaceAll("à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ", "a");
    str = str.replaceAll("è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ", "e");
    str = str.replaceAll("ì|í|ị|ỉ|ĩ", "i");
    str = str.replaceAll("ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ", "o");
    str = str.replaceAll("ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ", "u");
    str = str.replaceAll("ỳ|ý|ỵ|ỷ|ỹ", "y");
    str = str.replaceAll("đ", "d");
    str = str.replaceAll("\u0300|\u0301|\u0303|\u0309|\u0323", "");
    str = str.replaceAll("\u02C6|\u0306|\u031B", "");
    return str;
  }

  String get toNonAccentVietnamese {
    String str = this;
    str = str.replaceAll("A|Á|À|Ã|Ạ|Â|Ấ|Ầ|Ẫ|Ậ|Ă|Ắ|Ằ|Ẵ|Ặ", "A");
    str = str.replaceAll("à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ", "a");
    str = str.replaceAll("E|É|È|Ẽ|Ẹ|Ê|Ế|Ề|Ễ|Ệ", "E");
    str = str.replaceAll("è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ", "e");
    str = str.replaceAll("I|Í|Ì|Ĩ|Ị", "I");
    str = str.replaceAll("ì|í|ị|ỉ|ĩ", "i");
    str = str.replaceAll("O|Ó|Ò|Õ|Ọ|Ô|Ố|Ồ|Ỗ|Ộ|Ơ|Ớ|Ờ|Ỡ|Ợ", "O");
    str = str.replaceAll("ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ", "o");
    str = str.replaceAll("U|Ú|Ù|Ũ|Ụ|Ư|Ứ|Ừ|Ữ|Ự", "U");
    str = str.replaceAll("ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ", "u");
    str = str.replaceAll("Y|Ý|Ỳ|Ỹ|Ỵ", "Y");
    str = str.replaceAll("ỳ|ý|ỵ|ỷ|ỹ", "y");
    str = str.replaceAll("Đ", "D");
    str = str.replaceAll("đ", "d");
    str = str.replaceAll("\u0300|\u0301|\u0303|\u0309|\u0323", "");
    str = str.replaceAll("\u02C6|\u0306|\u031B", "");
    return str;
  }
}
