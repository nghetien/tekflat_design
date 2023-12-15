import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

/// A widget that displays a title and a form.
class TekItemTitleForm extends StatelessWidget {
  const TekItemTitleForm({
    Key? key,
    required this.title,
    this.heightSpace,
    required this.child,
    this.isRequired = false,
    this.requiredColor,
    this.spaceRequired,
  }) : super(key: key);

  final String title;
  final double? heightSpace;
  final Widget child;
  final bool isRequired;
  final Color? requiredColor;
  final double? spaceRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: heightSpace ?? TekSpacings().p4,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                TekTypography(
                  text: title,
                  type: TekTypographyType.bodyMedium,
                  fontWeight: FontWeight.w600,
                ),
                if (isRequired)
                  Positioned(
                    top: 0,
                    right: spaceRequired ?? -15,
                    child: TekTypography(
                      text: "*",
                      type: TekTypographyType.titleMediumMedium,
                      fontWeight: FontWeight.w600,
                      color: requiredColor ?? TekColors().red,
                    ),
                  ),
              ],
            ),
          ),
        child,
      ],
    );
  }
}