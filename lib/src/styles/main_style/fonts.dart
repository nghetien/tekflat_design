part of '../styles.dart';

class TekFonts {
  TekFonts._privateConstructor();

  static final TekFonts _instance = TekFonts._privateConstructor();

  factory TekFonts() => _instance;

  static const String $roboto = 'Roboto';

  String _defaultFont = $roboto;
  String _body = $roboto;
  String _label = $roboto;
  String _title = $roboto;
  String _headline = $roboto;
  String _display = $roboto;

  String get defaultFont => _defaultFont;

  String get body => _body;

  String get label => _label;

  String get title => _title;

  String get headline => _headline;

  String get display => _display;

  void setDefaultFont(String value) => _defaultFont = value;

  void setBody(String value) => _body = value;

  void setLabel(String value) => _label = value;

  void setTitle(String value) => _title = value;

  void setHeadline(String value) => _headline = value;

  void setDisplay(String value) => _display = value;

  void setFonts({
    String? body,
    String? label,
    String? title,
    String? headline,
    String? display,
  }) {
    _body = body ?? _body;
    _label = label ?? _label;
    _title = title ?? _title;
    _headline = headline ?? _headline;
    _display = display ?? _display;
  }
}