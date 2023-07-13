part of 'responsive.dart';

class TekScreenWidth {
  TekScreenWidth._privateConstructor();

  static final TekScreenWidth _instance = TekScreenWidth._privateConstructor();

  factory TekScreenWidth() => _instance;

  static const double $defaultDesktop = 1200;
  static const double $defaultTablet = 650;
  static const double $defaultMobile = 300;

  double _desktop = $defaultDesktop;
  double _tablet = $defaultTablet;
  double _mobile = $defaultMobile;

  double get widthDesktop => _desktop;

  double get widthTablet => _tablet;

  double get widthMobile => _mobile;

  void setScreenWidth({
    double? desktop,
    double? tablet,
    double? mobile,
  }) {
    _desktop = desktop ?? _desktop;
    _tablet = tablet ?? _tablet;
    _mobile = mobile ?? _mobile;
  }
}
