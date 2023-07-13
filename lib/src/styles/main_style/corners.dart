part of '../styles.dart';

class TekCorners {
  TekCorners._privateConstructor();

  static final TekCorners _instance = TekCorners._privateConstructor();

  factory TekCorners() => _instance;

  double _mainCorners = corner5;
  Radius _mainCornerRadius = cornerRadius5;
  BorderRadius _mainCornerBorder = cornerBorder5;

  double get mainCorners => _mainCorners;

  Radius get mainCornerRadius => _mainCornerRadius;

  BorderRadius get mainCornerBorder => _mainCornerBorder;

  void setMainCorners(double value) {
    _mainCorners = value;
    _mainCornerRadius = Radius.circular(value);
    _mainCornerBorder = BorderRadius.all(_mainCornerRadius);
  }

  /// ----------------------------------------------------------------------------------------------

  static const double corner3 = 3;
  static const Radius cornerRadius3 = Radius.circular(corner3);
  static const BorderRadius cornerBorder3 = BorderRadius.all(cornerRadius3);

  static const double corner5 = 5;
  static const Radius cornerRadius5 = Radius.circular(corner5);
  static const BorderRadius cornerBorder5 = BorderRadius.all(cornerRadius5);

  static const double corner8 = 8;
  static const Radius cornerRadius8 = Radius.circular(corner8);
  static const BorderRadius cornerBorder8 = BorderRadius.all(cornerRadius8);

  static const double corner11 = 11;
  static const Radius cornerRadius11 = Radius.circular(corner11);
  static const BorderRadius cornerBorder11 = BorderRadius.all(cornerRadius11);

  static const double corner20 = 20;
  static const Radius cornerRadius20 = Radius.circular(corner20);
  static const BorderRadius cornerBorder20 = BorderRadius.all(cornerRadius20);

  static const double corner30 = 30;
  static const Radius cornerRadius30 = Radius.circular(corner30);
  static const BorderRadius cornerBorder30 = BorderRadius.all(cornerRadius30);
}
