import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tekflat_design/tekflat_design.dart';

class TekSvgImage extends StatelessWidget {
  const TekSvgImage({
    super.key,
    required this.path,
    this.size,
    this.color,
    this.useDefaultTheme = true,
    this.useDefaultColorFilter = true,
  });

  final String path;
  final double? size;
  final Color? color;
  final bool useDefaultTheme;
  final bool useDefaultColorFilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      theme: useDefaultTheme
          ? null
          : SvgTheme(
              currentColor:
                  color ?? context.textTheme.titleMedium?.color ?? const Color(0xFF000000),
            ),
      colorFilter: useDefaultColorFilter
          ? null
          : ColorFilter.mode(
              color ?? context.textTheme.titleMedium?.color ?? const Color(0xFF000000),
              BlendMode.srcIn,
            ),
    );
  }
}
