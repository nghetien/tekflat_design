part of 'images.dart';

class TekNetworkImageForm extends StatelessWidget {
  const TekNetworkImageForm({
    /// Form
    this.name = '',
    this.initialValue,
    this.focusNodeForm,
    this.enabled = true,
    this.autoValidateMode,
    this.restorationId,
    this.validator,
    this.valueTransformer,
    this.onSaved,
    this.onChanged,
    this.onReset,

    /// Network Image
    super.key,
    this.size = TekImageSize.normal,
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

    /// Action
    this.onPressed,
  });

  /// Form
  final String name;
  final String? initialValue;
  final FocusNode? focusNodeForm;
  final bool enabled;
  final AutovalidateMode? autoValidateMode;
  final String? restorationId;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? valueTransformer;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function()? onReset;

  /// Network Image
  final TekImageSize size;
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

  /// Action
  final Function(FormFieldState<String> state)? onPressed;

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
              color: TekColors().greyOpacity04,
              border: Border.all(
                width: borderWidth ?? TekBorders.thin,
                color: borderColor ?? TekColors().primary,
              ),
              shape: shape,
              borderRadius: borderRadius ??
                  ((shape != BoxShape.circle) ? TekCorners().mainCornerBorder : null),
            ),
            child: child,
          );

  Widget _loading(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: context.theme.colorScheme.background,
        child: Container(
          width: width ?? size.size,
          height: height ?? size.size,
          decoration: BoxDecoration(
            color: TekColors().greyOpacity01,
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
  Widget build(BuildContext context) => FormBuilderField<String>(
        name: name,
        initialValue: initialValue,
        focusNode: focusNodeForm,
        enabled: enabled,
        autovalidateMode: autoValidateMode,
        restorationId: restorationId,
        validator: validator,
        valueTransformer: valueTransformer,
        onSaved: onSaved,
        onChanged: onChanged,
        onReset: onReset,
        builder: (FormFieldState<String> state) {
          if (state.value == null || state.value!.isEmpty) {
            return TekButtonInkwell(
              onPressed: () => onPressed?.call(state),
              child: _error(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_rounded,
                      size: 40.scaleIconSize,
                      color: TekColors().grey,
                    ),
                  ],
                ),
              ),
            );
          }
          return TekButtonInkwell(
            onPressed: () => onPressed?.call(state),
            child: CachedNetworkImage(
              imageUrl: state.value!,
              imageBuilder: (_, imageProvider) => TekAssetImage(
                width: width ?? size.size,
                height: height ?? size.size,
                borderWidth: borderWidth,
                borderColor: borderColor,
                shape: shape,
                borderRadius: borderRadius ??
                    ((shape != BoxShape.circle) ? TekCorners().mainCornerBorder : null),
                boxFit: boxFit,
                imageProvider: imageProvider,
              ),
              errorWidget: (_, __, ___) => _error(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_rounded,
                      size: 40.scaleIconSize,
                      color: TekColors().grey,
                    ),
                  ],
                ),
              ),
              progressIndicatorBuilder: (_, __, ___) => _loading(context),
            ),
          );
        },
      );
}
