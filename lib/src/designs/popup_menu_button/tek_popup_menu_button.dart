part of 'popup_menu_button.dart';

/// Phát triển lại trong tương lai
class TekPopupMenuButtonItemModel<T> {
  final IconData? icon;
  final String text;
  final T value;

  const TekPopupMenuButtonItemModel({
    this.icon,
    required this.text,
    required this.value,
  });
}

class TekPopupMenuButton<T> extends StatelessWidget {
  const TekPopupMenuButton({
    Key? key,
    this.icon,
    this.child,
    this.onPressed,
    required this.onSelected,
    required this.items,
    this.sectioned = const [],
    this.offset = Offset.zero,
    this.iconIsRight = false,
    this.iconItemColor,
    this.iconItemSize,
    this.style,
    this.padding,
  }) : super(key: key);

  final Icon? icon;
  final Widget? child;
  final VoidCallback? onPressed;
  final PopupMenuItemSelected<T> onSelected;
  final List<TekPopupMenuButtonItemModel<T>> items;
  final List<TekPopupMenuButtonItemModel<T>>? sectioned;
  final Offset offset;
  final bool iconIsRight;
  final Color? iconItemColor;
  final double? iconItemSize;
  final TextStyle? style;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuEntry<T>> menuItems = [];
    if (sectioned != null && sectioned!.isNotEmpty) {
      for (var item in sectioned!) {
        menuItems.add(
          _basePopupMenuItem(
            context,
            item: item,
            iconIsRight: iconIsRight,
            iconItemColor: iconItemColor,
            iconItemSize: iconItemSize,
            style: style,
          ),
        );
      }
      menuItems.add(
        PopupMenuDivider(
          height: 2.scaleSize,
        ),
      );
    }
    for (var item in items) {
      menuItems.add(
        _basePopupMenuItem(
          context,
          item: item,
          iconIsRight: iconIsRight,
          iconItemColor: iconItemColor,
          iconItemSize: iconItemSize,
          style: style,
        ),
      );
    }
    return PopupMenuButton<T>(
      icon: icon,
      offset: offset,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => menuItems,
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
      ),
      padding: padding ?? EdgeInsets.all(TekPaddings().p8),
      child: child,
    );
  }

  PopupMenuItem<T> _basePopupMenuItem(
    BuildContext context, {
    required TekPopupMenuButtonItemModel<T> item,
    bool iconIsRight = false,
    Color? iconItemColor,
    double? iconItemSize,
    TextStyle? style,
  }) =>
      PopupMenuItem<T>(
        value: item.value,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          minLeadingWidth: 0,
          horizontalTitleGap: TekPaddings().p12,
          leading: item.icon != null
              ? !iconIsRight
                  ? Icon(
                      item.icon,
                      color: iconItemColor,
                      size: iconItemSize ?? 26.scaleSize,
                    )
                  : null
              : null,
          trailing: item.icon != null
              ? iconIsRight
                  ? Icon(
                      item.icon,
                      color: iconItemColor,
                      size: iconItemSize ?? 26.scaleSize,
                    )
                  : null
              : null,
          title: Text(
            item.text,
            style: style ?? context.theme.textTheme.bodyMedium,
          ),
        ),
      );
}
