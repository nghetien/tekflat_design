part of 'responsive.dart';

class TekResponsiveConfig {
  TekResponsiveConfig._privateConstructor();

  static final TekResponsiveConfig _instance = TekResponsiveConfig._privateConstructor();

  factory TekResponsiveConfig() => _instance;

  TekScreenDevice _screenDevice = TekScreenDevice.mobile;

  double _currentWidth = 0;

  TekScreenDevice get screenDevice => _screenDevice;

  double get currentWidth => _currentWidth;

  void setScreenDevice(TekScreenDevice value) => _screenDevice = value;

  void setCurrentWidth(double value) => _currentWidth = value;

  TekScreenDevice getScreenDeviceFromWidth() {
    if (currentWidth >= TekScreenWidth().widthDesktop) {
      return TekScreenDevice.desktop;
    } else if (currentWidth >= TekScreenWidth().widthTablet) {
      return TekScreenDevice.tablet;
    } else {
      return TekScreenDevice.mobile;
    }
  }

  TekScreenDevice getRealScreenDeviceLayout() {
    if (currentWidth >= TekScreenWidth().widthDesktop) {
      if (TekPlatform.isWeb) return TekScreenDevice.desktop;
      return TekScreenDevice.tablet;
    } else if (currentWidth >= TekScreenWidth().widthTablet) {
      if (TekPlatform.isWeb) return TekScreenDevice.desktop;
      return TekScreenDevice.tablet;
    } else {
      return TekScreenDevice.mobile;
    }
  }

  void onResponsiveUpdate(double width) {
    setCurrentWidth(width);
    setScreenDevice(getScreenDeviceFromWidth());
  }
}
