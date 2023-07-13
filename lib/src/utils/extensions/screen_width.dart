import 'package:tekflat_design/src/responsive/responsive.dart';

extension TekScreenDeviceEx on TekScreenDevice {
  bool get isMobile => TekScreenDevice.mobile == this;

  bool get isTablet => TekScreenDevice.tablet == this;

  bool get isDesktop => TekScreenDevice.desktop == this;
}
