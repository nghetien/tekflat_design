part of '../styles.dart';

class TekIconSizes {
  TekIconSizes._privateConstructor();

  static final TekIconSizes _instance = TekIconSizes._privateConstructor();

  factory TekIconSizes() => _instance;

  double _scale = 1;

  void setScale(double value) => _scale = value;

  double get scale => _scale;

  double get s14 => 14 * _scale;

  double get s18 => 18 * _scale;

  double get s20 => 20 * _scale;

  double get s24 => 24 * _scale;

  double get s32 => 32 * _scale;

  double get s40 => 40 * _scale;
}
