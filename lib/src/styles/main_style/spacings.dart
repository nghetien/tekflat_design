part of '../styles.dart';

class TekSpacings {
  TekSpacings._privateConstructor();

  static final TekSpacings _instance = TekSpacings._privateConstructor();

  factory TekSpacings() => _instance;

  double _scale = 1;

  double get scale => _scale;

  void setScale(double value) => _scale = value;

  /// ----------------------------------------------------------------------------------------------

  double _mainSpacing = 14;

  double get mainSpacing => _mainSpacing * scale;

  void setMainPadding(double value) => _mainSpacing = value;

  /// ----------------------------------------------------------------------------------------------

  double get p4 => 4 * _scale;

  double get p6 => 6 * _scale;

  double get p8 => 8 * _scale;

  double get p12 => 12 * _scale;

  double get p14 => 14 * _scale;

  double get p18 => 18 * _scale;

  double get p32 => 32 * _scale;
}
