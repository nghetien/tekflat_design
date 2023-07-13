part of '../styles.dart';

class TekPaddings {
  TekPaddings._privateConstructor();

  static final TekPaddings _instance = TekPaddings._privateConstructor();

  factory TekPaddings() => _instance;

  double _scale = 1;

  double get scale => _scale;

  void setScale(double value) => _scale = value;

  /// ----------------------------------------------------------------------------------------------

  double _mainPadding = 14;

  double get mainPadding => _mainPadding * _scale;

  void setMainPadding(double value) => _mainPadding = value;

  /// ----------------------------------------------------------------------------------------------

  double get p4 => 4 * _scale;

  double get p8 => 8 * _scale;

  double get p12 => 12 * _scale;

  double get p14 => 14 * _scale;

  double get p18 => 18 * _scale;

  double get p32 => 32 * _scale;
}
