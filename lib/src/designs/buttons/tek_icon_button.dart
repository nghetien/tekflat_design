part of 'buttons.dart';

class TekIconButton extends StatelessWidget {
  const TekIconButton({
    super.key,
    this.icon,
    this.padding,
    this.iconData,
    this.iconColor,
    this.iconSize,
    this.onPressed,
  });

  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final IconData? iconData;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onPressed;

  Widget get currentIconWidget {
    late Widget currentIcon;
    if (iconData != null) {
      currentIcon = Icon(
        iconData,
        color: iconColor,
        size: iconSize ?? TekIconSizes().s18,
      );
    } else if (icon != null) {
      currentIcon = icon!;
    } else {
      currentIcon = Container();
    }

    return currentIcon;
  }

  @override
  Widget build(BuildContext context) => TekButtonInkwell(
        onPressed: onPressed,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          padding: padding ?? EdgeInsets.all(TekSpacings().p8),
          child: currentIconWidget,
        ),
      );
}
