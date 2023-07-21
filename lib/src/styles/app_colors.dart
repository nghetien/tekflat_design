part of 'styles.dart';

class TekColors {
  TekColors._privateConstructor();

  static final TekColors _instance = TekColors._privateConstructor();

  factory TekColors() => _instance;

  /// Default color
  static const Color _defaultPrimary = Color(0xFF806DFF);
  static const Color _defaultPrimaryLight = Color(0xFF9F54FC);
  static const Color _defaultPrimaryDark = Color(0xFF6F58FF);

  /// The color of the app.
  Color _primary = _defaultPrimary;
  Color _primaryLight = _defaultPrimaryLight;
  Color _primaryDark = _defaultPrimaryDark;

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
  static const Color _defaultBgPrimaryThemeDark = Color(0xFF1F1D2C);
  static const Color _defaultBgSecondaryThemeDark = Color(0xFF262837);
  static const Color _defaultBgPrimaryThemeLight = Color(0xFFF0F2F5);
  static const Color _defaultBgSecondaryThemeLight = white;

  Color _bgPrimaryThemeDark = _defaultBgPrimaryThemeDark;
  Color _bgSecondaryThemeDark = _defaultBgSecondaryThemeDark;
  Color _bgPrimaryThemeLight = _defaultBgPrimaryThemeLight;
  Color _bgSecondaryThemeLight = _defaultBgSecondaryThemeLight;

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
  static const Color red = Color(0xFFDA4343);
  static const Color yellow = Color(0xFFFFA940);
  static const Color blue =  Color(0xFF1990FF);
  static const Color green = Color(0xFF30CD60);
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
