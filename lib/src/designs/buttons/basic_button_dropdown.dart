part of 'buttons.dart';

/// Phát triển lại trong tương lai
class TekButtonDropdownModel {
  const TekButtonDropdownModel({
    required this.child,
    required this.isButtonDropdown,
    this.backgroundColor,
    this.textAndIconColor,
  });

  final Widget child;
  final bool isButtonDropdown;
  final Color? backgroundColor;
  final Color? textAndIconColor;
}

class TekButtonDropdown extends StatefulWidget {
  const TekButtonDropdown({
    Key? key,
    required this.titleButton,
    this.children = const [],
    this.onPressedTitleButton,
    this.onPressedItem,
    this.size = TekButtonSize.medium,
    this.type = TekButtonType.none,
    this.width,
    this.height,
    this.padding,
    this.background,
    this.hoverColor,
    this.shadowColor = Colors.transparent,
    this.boxShadow,
    this.splashFactory,
    this.shape,
    this.textColor,
    this.fontSize,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.maxLines = 4,
    this.alignment,
    this.colorWhenDropdown,
    this.isShowDropdown = false,
    this.colorIconDropdown,
  }) : super(key: key);

  final Widget titleButton;
  final List<TekButtonDropdownModel> children;
  final VoidCallback? onPressedTitleButton;
  final Function(int)? onPressedItem;
  final TekButtonSize size;
  final TekButtonType type;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? background;
  final Color? hoverColor;
  final Color shadowColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final List<BoxShadow>? boxShadow;
  final OutlinedBorder? shape;
  final Color? textColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int maxLines;
  final AlignmentGeometry? alignment;
  final Color? colorWhenDropdown;
  final bool isShowDropdown;
  final Color? colorIconDropdown;

  @override
  State<TekButtonDropdown> createState() => _TekButtonDropdownState();
}

class _TekButtonDropdownState extends State<TekButtonDropdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<double> _rotateAnimation;
  final double _heightButton = 52;
  late final double _heightDropdown;

  @override
  void initState() {
    super.initState();
    _heightDropdown = widget.children.length * _heightButton;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<double>(
      begin: widget.isShowDropdown ? _heightDropdown : 0,
      end: widget.isShowDropdown ? 0 : _heightDropdown,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );
    _rotateAnimation = Tween<double>(
      begin: widget.isShowDropdown ? 0.25 : 0,
      end: widget.isShowDropdown ? 0 : 0.25,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final mainColor = _animation.value == 0
              ? widget.background
              : widget.colorWhenDropdown ?? widget.background;
          return Column(
            children: [
              TekButton(
                size: widget.size,
                type: widget.type,
                onPressed: () {
                  _toggle();
                  if (widget.onPressedTitleButton != null) widget.onPressedTitleButton!();
                },
                width: widget.width,
                height: widget.height,
                background: mainColor,
                hoverColor: widget.hoverColor,
                shadowColor: widget.shadowColor,
                splashFactory: widget.splashFactory,
                boxShadow: widget.boxShadow,
                shape: widget.shape,
                textColor: widget.textColor,
                fontSize: widget.fontSize,
                textStyle: widget.textStyle,
                textAlign: widget.textAlign,
                maxLines: widget.maxLines,
                alignment: widget.alignment,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: widget.titleButton,
                    ),
                    RotationTransition(
                      turns: _rotateAnimation,
                      child: Icon(
                        Icons.chevron_right,
                        color: widget.colorIconDropdown,
                      ),
                    ),
                  ],
                ),
              ),
              ..._listDropdownButton(animationHeight: _animation.value),
            ],
          );
        },
      );

  List<Widget> _listDropdownButton({
    double? animationHeight,
  }) {
    final mainColor =
        animationHeight == 0 ? widget.background : widget.colorWhenDropdown ?? widget.background;
    return widget.children.map(
      (e) {
        final index = widget.children.indexOf(e);
        if (_animation.value > index * _heightButton) {
          return widget.children[index].isButtonDropdown
              ? widget.children[index].child
              : TekButton(
                  size: widget.size,
                  type: widget.type,
                  onPressed: () => widget.onPressedItem?.call(index),
                  width: widget.width ?? double.infinity,
                  height: widget.height,
                  background: widget.children[index].backgroundColor ?? mainColor,
                  hoverColor: widget.hoverColor,
                  shadowColor: widget.shadowColor,
                  splashFactory: widget.splashFactory,
                  boxShadow: widget.boxShadow,
                  shape: widget.shape,
                  textColor: widget.textColor,
                  fontSize: widget.fontSize,
                  textStyle: widget.textStyle,
                  textAlign: widget.textAlign,
                  maxLines: widget.maxLines,
                  alignment: widget.alignment,
                  child: widget.children[index].child,
                );
        }
        return const SizedBox.shrink();
      },
    ).toList();
  }
}
