part of 'images.dart';

class TekNetworkImage extends StatelessWidget {
  const TekNetworkImage({
    Key? key,
    this.size = TekImageSize.normal,
    this.path,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.boxFit = BoxFit.cover,
    this.assetPathWhenError,
    this.imageProviderWhenError,
    this.childOnError,
  }) : super(key: key);

  final TekImageSize size;
  final String? path;
  final double? width;
  final double? height;
  final double? borderWidth;
  final Color? borderColor;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final BoxFit boxFit;
  final String? assetPathWhenError;
  final ImageProvider? imageProviderWhenError;
  final Widget? childOnError;

  Widget _error({Widget? child}) => assetPathWhenError != null
      ? TekAssetImage(
          path: assetPathWhenError!,
          width: width ?? size.size,
          height: height ?? size.size,
          borderWidth: borderWidth,
          borderColor: borderColor,
          shape: shape,
          borderRadius: borderRadius,
          boxFit: boxFit,
          imageProvider: imageProviderWhenError,
        )
      : childOnError ??
          Container(
            width: width ?? size.size,
            height: height ?? size.size,
            decoration: BoxDecoration(
              color: TekColors.greyOpacity04,
              border: Border.all(
                width: borderWidth ?? TekBorders.thin,
                color: borderColor ?? TekColors().primary,
              ),
              shape: shape,
              borderRadius: borderRadius ??
                  ((shape != BoxShape.circle) ? TekCorners().mainCornerBorder : null),
            ),
          );

  Widget _loading(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: context.theme.colorScheme.background,
        child: Container(
          width: width ?? size.size,
          height: height ?? size.size,
          decoration: BoxDecoration(
            color: TekColors.greyOpacity01,
            border: Border.all(
              width: borderWidth ?? TekBorders.thin,
              color: borderColor ?? TekColors().primary,
            ),
            shape: shape,
            borderRadius:
                borderRadius ?? ((shape != BoxShape.circle) ? TekCorners().mainCornerBorder : null),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => (path == null || path!.isEmpty)
      ? _error(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_rounded,
                size: 40.scaleIconSize,
                color: TekColors.grey,
              ),
            ],
          ),
        )
      : CachedNetworkImage(
          imageUrl: path!,
          imageBuilder: (_, imageProvider) => TekAssetImage(
            width: width ?? size.size,
            height: height ?? size.size,
            borderWidth: borderWidth,
            borderColor: borderColor,
            shape: shape,
            borderRadius:
                borderRadius ?? ((shape != BoxShape.circle) ? TekCorners().mainCornerBorder : null),
            boxFit: boxFit,
            imageProvider: imageProvider,
          ),
          errorWidget: (_, __, ___) => _error(),
          progressIndicatorBuilder: (_, __, ___) => _loading(context),
        );
}
