part of '../styles.dart';

class TekFontSizes {
  TekFontSizes._privateConstructor();

  static final TekFontSizes _instance = TekFontSizes._privateConstructor();

  factory TekFontSizes() => _instance;

  double _scale = 1;

  void setScale(double value) => _scale = value;

  double get scale => _scale;

  double get s10 => 10 * _scale;

  double get s11 => 11 * _scale;

  double get s12 => 12 * _scale;

  double get s13 => 13 * _scale;

  double get s14 => 14 * _scale;

  double get s15 => 15 * _scale;

  double get s16 => 16 * _scale;

  double get s17 => 17 * _scale;

  double get s18 => 18 * _scale;

  double get s19 => 19 * _scale;

  double get s20 => 20 * _scale;

  double get s22 => 22 * _scale;

  double get s24 => 24 * _scale;

  double get s36 => 36 * _scale;

  double get s48 => 48 * _scale;
}