part of 'responsive.dart';

class TekResponsiveConfig {
  TekResponsiveConfig._privateConstructor();

  static final TekResponsiveConfig _instance = TekResponsiveConfig._privateConstructor();

  factory TekResponsiveConfig() => _instance;

  List<double> _scales = [1, 1.05, 1.1];
  double _scale = 1;
  TekScreenDevice _screenDevice = TekScreenDevice.mobile;
  double _currentWidth = 0;

  List<double> get scales => _scales;

  double get scale => _scale;

  TekScreenDevice get screenDevice => _screenDevice;

  double get currentWidth => _currentWidth;

  void setScales(List<double> value) => _scales = value;

  void setScale(double value) => _scale = value;

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

  double getScaleFromScreenDevice() {
    switch (screenDevice) {
      case TekScreenDevice.desktop:
        return _scales[2];
      case TekScreenDevice.tablet:
        return _scales[1];
      default:
        return _scales[0];
    }
  }

  void onResponsiveUpdate(double width) {
    setCurrentWidth(width);
    setScreenDevice(getScreenDeviceFromWidth());
    setScale(getScaleFromScreenDevice());
  }
}
