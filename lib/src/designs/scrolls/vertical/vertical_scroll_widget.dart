part of '../scrolls.dart';

class TekVerticalScrollWidget extends StatefulWidget {
  const TekVerticalScrollWidget({
    Key? key,
    required this.scrollController,
    required this.maxScroll,
    required this.scrollHeight,
    required this.initCurrentPosition,
    required this.scrollWidth,
    required this.scrollWidthOnHover,
    this.ratioOfScroll,
    this.backgroundColor,
    this.scrollColor,
  }) : super(key: key);

  final ScrollController scrollController;
  final double maxScroll;
  final double scrollHeight;
  final double initCurrentPosition;
  final double scrollWidth;
  final double scrollWidthOnHover;
  final double? ratioOfScroll;

  final Color? backgroundColor;
  final Color? scrollColor;

  @override
  State<TekVerticalScrollWidget> createState() => TekVerticalScrollWidgetState();
}

class TekVerticalScrollWidgetState extends State<TekVerticalScrollWidget> {
  final _scrollGlobalKey = GlobalKey();
  final Duration _durationAnimation = const Duration(milliseconds: 500);
  final Curve _curveAnimation = Curves.easeInOut;
  late double _maxScroll;
  late double _scrollHeight;
  late double _currentPosition;
  double _dragStartPosition = 0;
  bool _isDrag = true;
  late double _scrollWidth;
  bool _hideListeningScroll = false;

  void _listenScroll() {
    if (_hideListeningScroll) return;
    _isDrag = true;
    _currentPosition = (widget.scrollController.position.pixels /
            widget.scrollController.position.maxScrollExtent) *
        (_maxScroll - _scrollHeight);
    if (_currentPosition < 0.0) {
      _currentPosition = 0.0;
    } else if (_currentPosition > _maxScroll - _scrollHeight) {
      _currentPosition = _maxScroll - _scrollHeight;
    }
    setState(() {});
  }

  @override
  void initState() {
    _maxScroll = widget.maxScroll;
    _scrollHeight = widget.scrollHeight;
    _currentPosition = widget.initCurrentPosition;
    _scrollWidth = widget.scrollWidth;
    widget.scrollController.addListener(_listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_listenScroll);
    super.dispose();
  }

  Offset? get currentPositionScroll {
    final RenderBox? scrollBox = _scrollGlobalKey.currentContext?.findRenderObject() as RenderBox?;
    return scrollBox?.localToGlobal(Offset.zero);
  }

  double get _halfOfHeightScroll => _scrollHeight / 2;

  double get _ratioOfWidthScrollHeightScroll =>
      widget.scrollController.position.maxScrollExtent / (_maxScroll - _scrollHeight);

  void setScrollHeight(double value) => setState(
        () {
          _scrollHeight = value;
          _isDrag = true;
        },
      );

  void setMaxScroll(double value) => setState(
        () {
          _maxScroll = value;
          _isDrag = true;
        },
      );

  void setCurrentPosition(double value) {
    _currentPosition = value;
    if (_currentPosition >= _maxScroll - _scrollWidth) {
      _currentPosition = _maxScroll - _scrollWidth;
    }
    _isDrag = true;
    setState(() {});
  }

  void _setCurrentPosition(double value) {
    _hideListeningScroll = true;
    _currentPosition += value;
    if (_currentPosition < 0.0) {
      _currentPosition = 0.0;
    } else if (_currentPosition >= _maxScroll - _scrollHeight) {
      _currentPosition = _maxScroll - _scrollHeight;
    }
    if (_isDrag) {
      widget.scrollController.jumpTo(_currentPosition * _ratioOfWidthScrollHeightScroll);
      _hideListeningScroll = false;
    } else {
      widget.scrollController
          .animateTo(
            _currentPosition * _ratioOfWidthScrollHeightScroll,
            duration: _durationAnimation,
            curve: _curveAnimation,
          )
          .then((value) => _hideListeningScroll = false);
    }
    setState(() {});
  }

  void _startDrag(DragStartDetails details) => _dragStartPosition = details.globalPosition.dy;

  void _onDrag(DragUpdateDetails details) {
    double delta = details.globalPosition.dy - _dragStartPosition;
    _isDrag = true;
    _setCurrentPosition(delta);
    _dragStartPosition = details.globalPosition.dy;
  }

  void _onTapToScrollBar(DragStartDetails details) {
    _dragStartPosition = currentPositionScroll!.dy + _halfOfHeightScroll;
    double delta = details.globalPosition.dy - _dragStartPosition;
    if (details.globalPosition.dy > _dragStartPosition + _scrollHeight * 2) {
      delta = _scrollHeight * 2;
    }
    if (details.globalPosition.dy < _dragStartPosition - _scrollHeight * 2) {
      delta = -_scrollHeight * 2;
    }
    _isDrag = false;
    _setCurrentPosition(delta);
  }

  void _onScroll(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      double delta = event.scrollDelta.dy * (widget.ratioOfScroll ?? 0.3);
      _isDrag = true;
      _setCurrentPosition(delta);
    }
  }

  void _onHoverScroll(PointerHoverEvent event) =>
      setState(() => _scrollWidth = widget.scrollWidthOnHover);

  void _onExitScroll(PointerExitEvent event) => setState(() => _scrollWidth = widget.scrollWidth);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerSignal: _onScroll,
        child: GestureDetector(
          onVerticalDragStart: _onTapToScrollBar,
          child: Container(
            height: _maxScroll,
            width: widget.scrollWidthOnHover,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? context.theme.colorScheme.onSurface,
              border: Border(
                left: BorderSide(
                  color: TekColors().greyOpacity04,
                  width: 0,
                ),
                right: BorderSide(
                  color: TekColors().greyOpacity04,
                  width: 0,
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedPositioned(
                  duration: _isDrag ? Duration.zero : _durationAnimation,
                  curve: _curveAnimation,
                  top: _currentPosition,
                  child: GestureDetector(
                    onVerticalDragStart: _startDrag,
                    onVerticalDragUpdate: _onDrag,
                    child: MouseRegion(
                      onHover: _onHoverScroll,
                      onExit: _onExitScroll,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                        key: _scrollGlobalKey,
                        width: _scrollWidth,
                        height: _scrollHeight,
                        decoration: BoxDecoration(
                          color: widget.scrollColor ?? TekColors().greyOpacity04,
                          borderRadius: TekCorners.cornerBorder11,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
