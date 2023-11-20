part of 'responsive.dart';

class TekResponsive {
  TekResponsive._();

  static Widget appResBuilder(
    Widget child, {
    Key? key,
  }) =>
      LayoutBuilder(
        key: key,
        builder: (context, constraints) {
          TekResponsiveConfig().onResponsiveUpdate(constraints.maxWidth);
          TekOverlaySnackBar.setOverlayState(context.overlayState);
          return child;
        },
      );

  static Widget resBuilder({
    Key? key,
    Widget? children,
    Widget? mobile,
    Widget? tablet,
    Widget? desktop,
  }) =>
      LayoutBuilder(
        key: key,
        builder: (_, __) {
          switch (TekResponsiveConfig().screenDevice) {
            case TekScreenDevice.desktop:
              return desktop ?? children!;
            case TekScreenDevice.tablet:
              return tablet ?? children!;
            default:
              return mobile ?? children!;
          }
        },
      );

  static Widget resBuilderWithOutLB({
    Widget? children,
    Widget? mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    switch (TekResponsiveConfig().screenDevice) {
      case TekScreenDevice.desktop:
        return desktop ?? children!;
      case TekScreenDevice.tablet:
        return tablet ?? children!;
      default:
        return mobile ?? children!;
    }
  }
}
