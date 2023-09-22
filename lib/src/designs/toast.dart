import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekToast {
  const TekToast._();

  static Future<bool?> toast({
    required String msg,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.TOP,
        timeInSecForIosWeb: timeInSecForIosWeb ?? 2,
        backgroundColor: backgroundColor,
        webBgColor: '#${backgroundColor.value.toRadixString(16).substring(2, 8)}',
        textColor: textColor,
        fontSize: 16,
      );

  static Future<bool?> success({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) =>
      toast(
        msg: msg,
        backgroundColor: TekColors().green,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIosWeb,
      );

  static Future<bool?> error({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) =>
      toast(
        msg: msg,
        backgroundColor: TekColors().red,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIosWeb,
      );

  static Future<bool?> info({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) =>
      toast(
        msg: msg,
        backgroundColor: TekColors().blue,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIosWeb,
      );

  static Future<bool?> warning({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) =>
      toast(
        msg: msg,
        backgroundColor: TekColors().yellow,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIosWeb,
      );
}
