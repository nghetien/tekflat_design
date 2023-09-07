import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekExpansion extends StatelessWidget {
  const TekExpansion({
    Key? key,
    this.title,
    this.customTitle,
    this.leading,
    this.trailing,
    this.children = const [],
    this.color,
    this.collapsedTextColor,
    this.collapsedIconColor,
    this.iconColor,
    this.childrenPadding,
    this.tilePadding,
    this.border,
    this.borderRadius,
    this.expandedCrossAxisAlignment,
    this.titleColor,
    this.titleFontWeight,
    this.initiallyExpanded = false,
  }) : super(key: key);

  final String? title;
  final Widget? customTitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget> children;
  final Color? color;
  final Color? collapsedTextColor;
  final Color? collapsedIconColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? childrenPadding;
  final EdgeInsetsGeometry? tilePadding;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        border: border ??
            Border.all(
              color: TekColors.greyOpacity04,
              width: TekBorders.thin,
            ),
      ),
      child: ExpansionTile(
        key: key,
        initiallyExpanded: initiallyExpanded,
        title: customTitle ??
            Text(
              title ?? '',
              style: TekTextStyles.body.copyWith(
                color: titleColor,
                fontWeight: titleFontWeight,
              ),
            ),
        leading: leading,
        trailing: trailing,
        expandedCrossAxisAlignment: expandedCrossAxisAlignment,
        tilePadding: tilePadding,
        childrenPadding: childrenPadding ?? EdgeInsets.all(TekSpacings().mainSpacing),
        collapsedTextColor: collapsedTextColor,
        collapsedIconColor: collapsedIconColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        ),
        iconColor: iconColor,
        children: children,
      ),
    );
  }
}
