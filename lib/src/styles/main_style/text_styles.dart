part of '../styles.dart';

class TekTextStyles {
  TekTextStyles._privateConstructor();

  static final TekTextStyles _instance = TekTextStyles._privateConstructor();

  factory TekTextStyles() => _instance;

  static final TextStyle _defaultLabel = TextStyle(
    fontFamily: TekFonts().label,
    letterSpacing: 0.1,
    fontSize: TekFontSizes().s12,
  );

  static final TextStyle _defaultBody = TextStyle(
    fontFamily: TekFonts().body,
    letterSpacing: 0.15,
    fontSize: TekFontSizes().s14,
  );

  static final TextStyle _defaultTitleMedium = TextStyle(
    fontFamily: TekFonts().title,
    letterSpacing: 0.15,
    fontSize: TekFontSizes().s16,
  );

  static final TextStyle _defaultTitleLarge = TextStyle(
    fontFamily: TekFonts().title,
    letterSpacing: 0,
    fontSize: TekFontSizes().s22,
  );

  static final TextStyle _defaultHeadline = TextStyle(
    fontFamily: TekFonts().headline,
    letterSpacing: 0,
    fontSize: TekFontSizes().s24,
  );

  static final TextStyle _defaultDisplay = TextStyle(
    fontFamily: TekFonts().display,
    letterSpacing: 0,
    fontSize: TekFontSizes().s36,
  );

  TextStyle _label = _defaultLabel;
  TextStyle _body = _defaultBody;
  TextStyle _titleMedium = _defaultTitleMedium;
  TextStyle _titleLarge = _defaultTitleLarge;
  TextStyle _headline = _defaultHeadline;
  TextStyle _display = _defaultDisplay;

  TextStyle get label => _label;

  TextStyle get body => _body;

  TextStyle get titleMedium => _titleMedium;

  TextStyle get titleLarge => _titleLarge;

  TextStyle get headline => _headline;

  TextStyle get display => _display;

  void settLabel(TextStyle value) => _label = value;

  void setBody(TextStyle value) => _body = value;

  void setTitleMedium(TextStyle value) => _titleMedium = value;

  void setTitleLarge(TextStyle value) => _titleLarge = value;

  void setHeadline(TextStyle value) => _headline = value;

  void setDisplay(TextStyle value) => _display = value;

  void setTextStyles({
    TextStyle? label,
    TextStyle? body,
    TextStyle? titleMedium,
    TextStyle? titleLarge,
    TextStyle? headline,
    TextStyle? display,
  }) {
    _label = label ?? _defaultLabel;
    _body = body ?? _defaultBody;
    _titleMedium = titleMedium ?? _defaultTitleMedium;
    _titleLarge = titleLarge ?? _defaultTitleLarge;
    _headline = headline ?? _defaultHeadline;
    _display = display ?? _defaultDisplay;
  }
}
