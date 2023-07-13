import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class TekJsonFileHelpers {
  const TekJsonFileHelpers._();

  static Future<String> readJson(String address) => rootBundle.loadString(address);

  /// * read file json from assets
  static Future readAssetJson(String address) async {
    final String jsonString = await rootBundle.loadString(address);
    final data = await json.decode(jsonString);
    return data;
  }

  /// * read file json without declare path assets in pubspec.yaml
  /// * use for unit test
  /// * use only mobile
  static Future readOutSidesJson(String address) async {
    final String jsonString = File(address).readAsStringSync();
    final data = await json.decode(jsonString);
    return data;
  }
}
