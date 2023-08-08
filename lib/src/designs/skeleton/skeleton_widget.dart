part of 'skeleton.dart';

///
/// antd
/// https://ant.design/components/skeleton#api
///
/// [direction] - The animation direction of the gradient effect.
/// [effectSpeed] - The animation speed of the gradient effect.
/// [baseColor] - The background color of the skeleton.
/// [active] - Whether to show animation effect.
/// [avatar] - Whether to show avatar placeholder.
/// [paragraph] - Whether to show paragraph placeholder.
/// [title] - Whether to show title placeholder.
/// [child] - The children content of the skeleton. If it is set, the avatar, title and paragraph will not be displayed.
///
@immutable
class TekSkeleton extends StatelessWidget {
  final TekSkeletonDirection direction;
  final Duration effectSpeed;
  final Color baseColor;
  final Widget? child;

  final bool active;
  final TekSkeletonAvatarProps? avatar;
  final TekSkeletonParagraphProps? paragraph;
  final TekSkeletonTitleProps? title;

  const TekSkeleton({
    super.key,
    this.baseColor = TekSkeletonConstants.defaultBaseColor,
    this.direction = TekSkeletonDirection.ltr,
    this.effectSpeed = const Duration(milliseconds: 2500),
    this.active = false,
    this.avatar,
    this.paragraph,
    this.title,
    this.child,
  }) : assert(
          child == null || (avatar == null && paragraph == null && title == null),
          'You can not use child with avatar, paragraph or title',
        );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: active,
      baseColor: baseColor,
      highlightColor: Colors.black.withOpacity(0.06),
      direction: direction.convert,
      period: effectSpeed,
      child: child ?? _buildSkeleton(context),
    );
  }

  Widget _buildSkeleton(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (avatar != null) _avatar(avatar!),
              if (title != null) _title(title!),
            ],
          ),
          if (paragraph != null) TekVSpace.p8,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (avatar != null)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: TekSpacings().p14),
                  width: avatar!.size,
                  height: avatar!.size,
                ),
              if (paragraph != null) _paragraph(paragraph!),
            ],
          ),
        ],
      );

  Widget _avatar(TekSkeletonAvatarProps avatarProps) {
    late final BoxDecoration decoration;
    switch (avatarProps.shape) {
      case TekSkeletonShape.circle:
        decoration = const BoxDecoration(
          shape: BoxShape.circle,
          color: TekSkeletonConstants.defaultBaseColor,
        );
        break;
      case TekSkeletonShape.square:
      case TekSkeletonShape.round:
      case TekSkeletonShape.defaultShape:
        decoration = const BoxDecoration(
          shape: BoxShape.rectangle,
          color: TekSkeletonConstants.defaultBaseColor,
          borderRadius: TekSkeletonConstants.defaultBorderRadius,
        );
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: TekSpacings().p14),
      width: avatarProps.size,
      height: avatarProps.size,
      decoration: decoration,
    );
  }

  Widget _title(TekSkeletonTitleProps titleProps) => Container(
        decoration: const BoxDecoration(
          borderRadius: TekSkeletonConstants.defaultBorderRadius,
          color: TekSkeletonConstants.defaultBaseColor,
        ),
        width: titleProps.width,
        height: TekSkeletonConstants.defaultHeight,
      );

  Widget _paragraph(TekSkeletonParagraphProps paragraphProps) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < paragraphProps.rows; i++)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: TekSkeletonConstants.defaultBorderRadius,
                  color: TekSkeletonConstants.defaultBaseColor,
                ),
                width: paragraphProps.widths[i],
                height: TekSkeletonConstants.defaultHeight,
              ),
              if (i < paragraphProps.rows - 1) TekVSpace.p12,
            ],
          ),
      ],
    );
  }
}
