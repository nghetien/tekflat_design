part of '../styles.dart';

class TekTextStyles {
  TekTextStyles._privateConstructor();

  static final TekTextStyles _instance = TekTextStyles._privateConstructor();

  factory TekTextStyles() => _instance;

  static final TextStyle body = TextStyle(
    fontFamily: TekFonts().body,
    letterSpacing: 0.15,
    fontSize: TekFontSizes().s14,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle label = TextStyle(
    fontFamily: TekFonts().label,
    letterSpacing: 0.1,
    fontSize: TekFontSizes().s12,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle titleMedium = TextStyle(
    fontFamily: TekFonts().title,
    letterSpacing: 0.15,
    fontSize: TekFontSizes().s16,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle titleLarge = TextStyle(
    fontFamily: TekFonts().title,
    letterSpacing: 0,
    fontSize: TekFontSizes().s22,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle headline = TextStyle(
    fontFamily: TekFonts().headline,
    letterSpacing: 0,
    fontSize: TekFontSizes().s24,
    overflow: TextOverflow.ellipsis,
  );

static final TextStyle display = TextStyle(
    fontFamily: TekFonts().display,
    letterSpacing: 0,
    fontSize: TekFontSizes().s36,
    overflow: TextOverflow.ellipsis,
  );
}
