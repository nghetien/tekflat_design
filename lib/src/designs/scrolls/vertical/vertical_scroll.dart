part of '../scrolls.dart';

typedef TekVerticalScrollWrapperContent = Widget Function(Widget);

typedef TekVerticalScrollBuilder = Widget Function(
  BuildContext context,
  TekVerticalScrollWrapperContent child,
  Widget? scrollWidget,
);

class TekVerticalScroll extends StatefulWidget {
  const TekVerticalScroll({
    required this.scrollController,
    this.child,
    this.builder,
    this.scrollWidth = TekScrollConfig.scrollWidthInVertical,
    this.scrollWidgetOnHover = TekScrollConfig.scrollWidthInVerticalOnHover,
    this.ratioOfScroll,
    this.maxScroll,

    this.backgroundColor,
    this.scrollColor,
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
  final TekVerticalScrollBuilder? builder;
  final double scrollWidth;
  final double scrollWidgetOnHover;
  final double? ratioOfScroll;
  final double? maxScroll;

  final Color? backgroundColor;
  final Color? scrollColor;

  @override
  State<TekVerticalScroll> createState() => TekVerticalScrollState();
}

class TekVerticalScrollState extends State<TekVerticalScroll> {
  final _scrollGlobalKey = GlobalKey();
  late double _maxScroll;
  double _scrollHeight = 100;
  double _currentPosition = 0;
  bool _statusOfScrollBar = false;

  @override
  void initState() {
    _maxScroll = TekSizeOfDevice.deviceHeight;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateScroll();
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(TekVerticalScroll oldWidget) {
    if (oldWidget.maxScroll != widget.maxScroll && widget.maxScroll != null) {
      _maxScroll = widget.maxScroll ?? TekSizeOfDevice.deviceHeight;
    }
    calculateScroll();
    super.didUpdateWidget(oldWidget);
  }

  void calculateScroll({double? maxHeight}) {
    _maxScroll = maxHeight ?? _maxScroll;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final maxScrollExtent = widget.scrollController.position.maxScrollExtent;
        if (maxScrollExtent == 0) {
          _statusOfScrollBar = false;
          return;
        }
        _statusOfScrollBar = true;
        final scrollControllerOffset = widget.scrollController.offset;
        _scrollHeight = (_maxScroll / (_maxScroll + maxScrollExtent)) * _maxScroll;
        _currentPosition =
            (scrollControllerOffset / maxScrollExtent) * (_maxScroll - _scrollHeight);
        if (_currentPosition >= _maxScroll - _scrollHeight) {
          _currentPosition = _maxScroll - _scrollHeight;
        }
        (_scrollGlobalKey.currentState as TekVerticalScrollWidgetState?)
            ?.setMaxScroll(_maxScroll);
        (_scrollGlobalKey.currentState as TekVerticalScrollWidgetState?)
            ?.setScrollHeight(_scrollHeight);
        (_scrollGlobalKey.currentState as TekVerticalScrollWidgetState?)
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
                    calculateScroll(maxHeight: constraints.maxHeight);
                    return ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: widget.child!,
                    );
                  },
                ),
          if (_statusOfScrollBar)
            Positioned(
              right: 0,
              child: TekVerticalScrollWidget(
                key: _scrollGlobalKey,
                scrollController: widget.scrollController,
                maxScroll: _maxScroll,
                scrollHeight: _scrollHeight,
                initCurrentPosition: _currentPosition,
                scrollWidth: widget.scrollWidth,
                scrollWidthOnHover: widget.scrollWidgetOnHover,
                ratioOfScroll: widget.ratioOfScroll,
                backgroundColor: widget.backgroundColor,
                scrollColor: widget.scrollColor,
              ),
            ),
        ],
      );
    }
    return widget.builder!(
      context,
      (Widget content) => widget.maxScroll != null
          ? ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: content,
            )
          : LayoutBuilder(
              builder: (_, BoxConstraints constraints) {
                calculateScroll(maxHeight: constraints.maxHeight);
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: content,
                );
              },
            ),
      _statusOfScrollBar
          ? TekVerticalScrollWidget(
              key: _scrollGlobalKey,
              scrollController: widget.scrollController,
              maxScroll: _maxScroll,
              scrollHeight: _scrollHeight,
              initCurrentPosition: _currentPosition,
              scrollWidth: widget.scrollWidth,
              scrollWidthOnHover: widget.scrollWidgetOnHover,
              ratioOfScroll: widget.ratioOfScroll,
              backgroundColor: widget.backgroundColor,
              scrollColor: widget.scrollColor,
            )
          : null,
    );
  }
}
