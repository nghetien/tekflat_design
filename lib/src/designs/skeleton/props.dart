part of 'skeleton.dart';

///
/// An enum that defines the shape of the skeleton.
///
/// * [TekSkeletonShape.circle] - A circle shape.
/// * [TekSkeletonShape.square] - A square shape.
/// * [TekSkeletonShape.round] - A round shape.
/// * [TekSkeletonShape.defaultShape] - A default shape.
///
enum TekSkeletonShape { circle, square, round, defaultShape }

/// An enum that defines the direction of the skeleton.
///
/// * [TekSkeletonDirection.ltr] - Left to right direction.
/// * [TekSkeletonDirection.rtl] - Right to left direction.
/// * [TekSkeletonDirection.ttb] - Top to bottom direction.
/// * [TekSkeletonDirection.btt] - Bottom to top direction.
///
enum TekSkeletonDirection {
  ltr,
  rtl,
  ttb,
  btt;

  ShimmerDirection get convert {
    switch (this) {
      case TekSkeletonDirection.ltr:
        return ShimmerDirection.ltr;
      case TekSkeletonDirection.rtl:
        return ShimmerDirection.rtl;
      case TekSkeletonDirection.ttb:
        return ShimmerDirection.ttb;
      case TekSkeletonDirection.btt:
        return ShimmerDirection.btt;
    }
  }
}

///
/// A data class that defines the properties of avatar placeholder.
///
/// * [active] - A boolean value that defines the avatar is active or not.
/// * [shape] - A [TekSkeletonShape] value that defines the shape of the avatar.
/// * [size] - A double value that defines the size of the avatar.
///
class TekSkeletonAvatarProps {
  final bool active;
  final TekSkeletonShape shape;
  final double size;

  const TekSkeletonAvatarProps({
    this.active = false,
    this.shape = TekSkeletonShape.circle,
    this.size = TekSkeletonConstants.defaultAvatarSize,
  });
}

///
/// A data class that defines the properties of title placeholder.
///
/// * [width] - A double value that defines the width of the title.
///
class TekSkeletonTitleProps {
  final double width;

  const TekSkeletonTitleProps({
    this.width = TekSkeletonConstants.defaultWidth,
  });
}

///
/// A data class that defines the properties of paragraph placeholder.
///
/// * [rows] - An integer value that defines the number of rows of the paragraph.
/// * [widths] - A list of double values that defines the width of each row of the paragraph.
///
/// The number of rows must be equal to the number of widths.
///
class TekSkeletonParagraphProps {
  final int rows;
  final List<double> widths;

  const TekSkeletonParagraphProps({
    this.rows = 3,
    this.widths = const [
      TekSkeletonConstants.defaultWidth,
      TekSkeletonConstants.defaultWidth,
      TekSkeletonConstants.defaultWidth * 0.8,
    ],
  }) : assert(rows == widths.length, 'The number of rows must be equal to the number of widths');
}

///
/// A class that defines the constants of the skeleton.
///
/// * [defaultWidth] - A double value that defines the default width of the skeleton.
/// * [defaultHeight] - A double value that defines the default height of the skeleton.
/// * [defaultAvatarSize] - A double value that defines the default size of the avatar.
/// * [defaultBorderRadius] - A [BorderRadius] value that defines the default border radius of the skeleton.
/// * [defaultBaseColor] - A [Color] value that defines the default base color of the skeleton.
///
class TekSkeletonConstants {
  TekSkeletonConstants._();

  static const double defaultWidth = 320.0;
  static const double defaultHeight = 18.0;
  static const double defaultAvatarSize = 40.0;
  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(6.0));
  static const Color defaultBaseColor = Color(0xFFF2F2F2);

}
