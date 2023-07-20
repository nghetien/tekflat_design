part of 'styles.dart';

class TekColors {
  TekColors._privateConstructor();

  static final TekColors _instance = TekColors._privateConstructor();

  factory TekColors() => _instance;

  /// Default color
  static const Color $primary = Color(0xFF806DFF);
  static const Color $primaryLight = Color(0xFF9F54FC);
  static const Color $primaryDark = Color(0xFF6F58FF);

  /// The color of the app.
  Color _primary = $primary;
  Color _primaryLight = $primaryLight;
  Color _primaryDark = $primaryDark;

  Color get primary => _primary;

  Color get primaryLight => _primaryLight;

  Color get primaryDark => _primaryDark;

  void setColors({
    Color? primary,
    Color? primaryLight,
    Color? primaryDark,
  }) {
    _primary = primary ?? _primary;
    _primaryLight = primaryLight ?? _primaryLight;
    _primaryDark = primaryDark ?? _primaryDark;
  }

  /// The background color of the app.
  static const Color $bgPrimaryThemeDark = Color(0xFF1F1D2C);
  static const Color $bgSecondaryThemeDark = Color(0xFF262837);
  static const Color $bgPrimaryThemeLight = Color(0xFFF0F2F5);
  static const Color $bgSecondaryThemeLight = white;

  Color _bgPrimaryThemeDark = $bgPrimaryThemeDark;
  Color _bgSecondaryThemeDark = $bgSecondaryThemeDark;
  Color _bgPrimaryThemeLight = $bgPrimaryThemeLight;
  Color _bgSecondaryThemeLight = $bgSecondaryThemeLight;

  Color get bgPrimaryThemeDark => _bgPrimaryThemeDark;

  Color get bgSecondaryThemeDark => _bgSecondaryThemeDark;

  Color get bgPrimaryThemeLight => _bgPrimaryThemeLight;

  Color get bgSecondaryThemeLight => _bgSecondaryThemeLight;

  void setBgColors({
    Color? bgPrimaryThemeDark,
    Color? bgSecondaryThemeDark,
    Color? bgPrimaryThemeLight,
    Color? bgSecondaryThemeLight,
  }) {
    _bgPrimaryThemeDark = bgPrimaryThemeDark ?? _bgPrimaryThemeDark;
    _bgSecondaryThemeDark = bgSecondaryThemeDark ?? _bgSecondaryThemeDark;
    _bgPrimaryThemeLight = bgPrimaryThemeLight ?? _bgPrimaryThemeLight;
    _bgSecondaryThemeLight = bgSecondaryThemeLight ?? _bgSecondaryThemeLight;
  }

  /// The card color of the app.
  Color get cardThemeDark => _bgSecondaryThemeDark;

  Color get cardThemeLight => _bgSecondaryThemeLight;

  /// Color
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFAAB3AC);
  static const Color red = Colors.redAccent;
  static const Color yellow = Color(0xFFFFA000);
  static const Color blueLight = Colors.lightBlue;
  static const Color blue =  Color(0xFF1990FF);
  static const Color green = Color(0xFF4AB178);
  static const Color pink = Color(0xFFc41d7f);

  static final Color greyOpacity01 = grey.withOpacity(0.1);
  static final Color greyOpacity02 = grey.withOpacity(0.2);
  static final Color greyOpacity04 = grey.withOpacity(0.4);
  static final Color greyOpacity06 = grey.withOpacity(0.6);
  static final Color greyOpacity08 = grey.withOpacity(0.8);

  static final Color greenOpacity01 = green.withOpacity(0.1);

  Color get primaryOpacity01 => primary.withOpacity(0.1);
  Color get primaryOpacity02 => primary.withOpacity(0.2);
  Color get primaryOpacity04 => primary.withOpacity(0.4);
}
