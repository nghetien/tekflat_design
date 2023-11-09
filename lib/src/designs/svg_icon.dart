import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TekSvgIcon extends StatelessWidget {
  const TekSvgIcon({
    super.key,
    required this.path,
    this.size,
    this.color,
  });

  final String path;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      theme: SvgTheme(
        currentColor: color ?? const Color(0xFF000000),
      ),
      colorFilter: ColorFilter.mode(
        color ?? const Color(0xFF000000),
        BlendMode.srcIn,
      )
    );
  }
}
