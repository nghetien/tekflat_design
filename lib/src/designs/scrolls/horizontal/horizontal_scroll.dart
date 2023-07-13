part of '../scrolls.dart';

typedef TekHorizontalScrollWrapperContent = Widget Function(Widget);

typedef TekHorizontalScrollBuilder = Widget Function(
  BuildContext context,
  TekHorizontalScrollWrapperContent child,
  Widget? scrollWidget,
);

class TekHorizontalScroll extends StatefulWidget {
  const TekHorizontalScroll({
    required this.scrollController,
    this.child,
    this.builder,
    this.scrollHeight = TekScrollConfig.scrollHeightInHorizontal,
    this.scrollHeightOnHover = TekScrollConfig.scrollHeightInHorizontalOnHover,
    this.ratioOfScroll,
    this.maxScroll,
    Key? key,
  })  : assert(
          !(child != null && builder != null),
          'You can only pass [child] or [builder], not both.',
        ),
        assert(
          !(child == null && builder == null),
          'You must pass either [child] or [builder].',
        ),
        super(key: key);

  final ScrollController scrollController;
  final Widget? child;
  final TekHorizontalScrollBuilder? builder;
  final double scrollHeight;
  final double scrollHeightOnHover;
  final double? ratioOfScroll;
  final double? maxScroll;

  @override
  State<TekHorizontalScroll> createState() => CustomHorizontalState();
}

class CustomHorizontalState extends State<TekHorizontalScroll> {
  final _scrollGlobalKey = GlobalKey();
  late double _maxScroll;
  double _scrollWidth = 100;
  double _currentPosition = 0;
  bool _statusOfScrollBar = false;

  @override
  void initState() {
    _maxScroll = widget.maxScroll ?? TekSizeOfDevice.deviceWidth;
    WidgetsBinding.instance.addPostFrameCallback((_) => calculateScroll());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TekHorizontalScroll oldWidget) {
    if (oldWidget.maxScroll != widget.maxScroll && widget.maxScroll != null) {
      _maxScroll = widget.maxScroll ?? TekSizeOfDevice.deviceWidth;
    }
    calculateScroll();
    super.didUpdateWidget(oldWidget);
  }

  void calculateScroll({double? maxWidth}) {
    _maxScroll = maxWidth ?? _maxScroll;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final maxScrollExtent = widget.scrollController.position.maxScrollExtent;
        final bool preStatusOfScrollBar = _statusOfScrollBar;
        if (maxScrollExtent.floor() == 0) {
          _statusOfScrollBar = false;
          if (preStatusOfScrollBar != _statusOfScrollBar) setState(() {});
          return;
        }
        _statusOfScrollBar = true;
        if (preStatusOfScrollBar != _statusOfScrollBar) setState(() {});
        final scrollControllerOffset = widget.scrollController.offset;
        _scrollWidth = (_maxScroll / (_maxScroll + maxScrollExtent)) * _maxScroll;
        _currentPosition = (scrollControllerOffset / maxScrollExtent) * (_maxScroll - _scrollWidth);
        if (_currentPosition >= _maxScroll - _scrollWidth) {
          _currentPosition = _maxScroll - _scrollWidth;
        }
        (_scrollGlobalKey.currentState as TekHorizontalScrollWidgetState?)
            ?.setMaxScroll(_maxScroll);
        (_scrollGlobalKey.currentState as TekHorizontalScrollWidgetState?)
            ?.setScrollWidth(_scrollWidth);
        (_scrollGlobalKey.currentState as TekHorizontalScrollWidgetState?)
            ?.setCurrentPosition(_currentPosition);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return Stack(
        children: [
          widget.maxScroll != null
              ? ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: widget.child!,
                )
              : LayoutBuilder(
                  builder: (_, BoxConstraints constraints) {
                    calculateScroll(maxWidth: constraints.maxWidth);
                    return ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: widget.child!,
                    );
                  },
                ),
          if (_statusOfScrollBar)
            Positioned(
              bottom: 0,
              child: TekHorizontalScrollWidget(
                key: _scrollGlobalKey,
                scrollController: widget.scrollController,
                maxScroll: _maxScroll,
                scrollWidth: _scrollWidth,
                initCurrentPosition: _currentPosition,
                scrollHeight: widget.scrollHeight,
                scrollHeightOnHover: widget.scrollHeightOnHover,
                ratioOfScroll: widget.ratioOfScroll,
              ),
            ),
        ],
      );
    }
    return widget.builder!(
      context,
      (Widget content) {
        return widget.maxScroll != null
            ? ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: content,
              )
            : LayoutBuilder(
                builder: (_, BoxConstraints constraints) {
                  calculateScroll(maxWidth: constraints.maxWidth);
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: content,
                  );
                },
              );
      },
      _statusOfScrollBar
          ? TekHorizontalScrollWidget(
              key: _scrollGlobalKey,
              scrollController: widget.scrollController,
              maxScroll: _maxScroll,
              scrollWidth: _scrollWidth,
              initCurrentPosition: _currentPosition,
              scrollHeight: widget.scrollHeight,
              scrollHeightOnHover: widget.scrollHeightOnHover,
              ratioOfScroll: widget.ratioOfScroll,
            )
          : null,
    );
  }
}
