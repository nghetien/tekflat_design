import 'dart:io';

import 'package:flutter/foundation.dart';

class TekPlatform {
  TekPlatform._();

  static bool get isWeb => kIsWeb;

  static bool get isMobile => !isWeb && (Platform.isIOS || Platform.isAndroid);

  static bool get isDesktop =>
      !isWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  static bool get isApple => !isWeb && (Platform.isIOS || Platform.isMacOS);

  static bool get isGoogle => !isWeb && (Platform.isAndroid || Platform.isFuchsia);

  static bool get isAndroid => !isWeb && Platform.isAndroid;

  static bool get isIOS => !isWeb && Platform.isIOS;

  static bool get isMacOS => !isWeb && Platform.isMacOS;

  static bool get isLinux => !isWeb && Platform.isLinux;

  static bool get isWindows => !isWeb && Platform.isWindows;

  static String get operatingSystemName => Platform.operatingSystem;

  static String get operatingSystemVersion => Platform.operatingSystemVersion;

  static bool hasNotch(double screenHeight) {
    if (isWeb) return false;
    if (screenHeight >= 812) return true;
    return false;
  }
}
