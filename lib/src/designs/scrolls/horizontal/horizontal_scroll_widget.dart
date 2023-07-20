part of '../scrolls.dart';

class TekHorizontalScrollWidget extends StatefulWidget {
  const TekHorizontalScrollWidget({
    Key? key,
    required this.scrollController,
    required this.maxScroll,
    required this.scrollWidth,
    required this.initCurrentPosition,
    required this.scrollHeight,
    required this.scrollHeightOnHover,
    this.ratioOfScroll,
  }) : super(key: key);

  final ScrollController scrollController;
  final double maxScroll;
  final double scrollWidth;
  final double initCurrentPosition;
  final double scrollHeight;
  final double scrollHeightOnHover;
  final double? ratioOfScroll;

  @override
  State<TekHorizontalScrollWidget> createState() => TekHorizontalScrollWidgetState();
}

class TekHorizontalScrollWidgetState extends State<TekHorizontalScrollWidget> {
  final _scrollGlobalKey = GlobalKey();
  final Duration _durationAnimation = const Duration(milliseconds: 500);
  final Curve _curveAnimation = Curves.easeInOut;
  late double _maxScroll;
  late double _scrollWidth;
  late double _currentPosition;
  double _dragStartPosition = 0;
  bool _isDrag = true;
  late double _scrollHeight;
  bool _hideListeningScroll = false;

  void _listenScroll() {
    if (_hideListeningScroll) return;
    _isDrag = true;
    _currentPosition = (widget.scrollController.position.pixels /
            widget.scrollController.position.maxScrollExtent) *
        (_maxScroll - _scrollWidth);
    if (_currentPosition < 0.0) {
      _currentPosition = 0.0;
    } else if (_currentPosition > _maxScroll - _scrollWidth) {
      _currentPosition = _maxScroll - _scrollWidth;
    }
    setState(() {});
  }

  @override
  void initState() {
    _maxScroll = widget.maxScroll;
    _scrollWidth = widget.scrollWidth;
    _currentPosition = widget.initCurrentPosition;
    _scrollHeight = widget.scrollHeight;
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

  double get _halfOfWidthScroll => _scrollWidth / 2;

  double get _ratioOfWidthScrollWithScroll =>
      widget.scrollController.position.maxScrollExtent / (_maxScroll - _scrollWidth);

  void setScrollWidth(double value) => setState(
        () {
          _scrollWidth = value;
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
    } else if (_currentPosition >= _maxScroll - _scrollWidth) {
      _currentPosition = _maxScroll - _scrollWidth;
    }
    if (_isDrag) {
      widget.scrollController.jumpTo(_currentPosition * _ratioOfWidthScrollWithScroll);
      _hideListeningScroll = false;
    } else {
      widget.scrollController
          .animateTo(
            _currentPosition * _ratioOfWidthScrollWithScroll,
            duration: _durationAnimation,
            curve: _curveAnimation,
          )
          .then((value) => _hideListeningScroll = false);
    }
    setState(() {});
  }

  void _startDrag(DragStartDetails details) => _dragStartPosition = details.globalPosition.dx;

  void _onDrag(DragUpdateDetails details) {
    double delta = details.globalPosition.dx - _dragStartPosition;
    _isDrag = true;
    _setCurrentPosition(delta);
    _dragStartPosition = details.globalPosition.dx;
  }

  void _onTapToScrollBar(DragStartDetails details) {
    _dragStartPosition = currentPositionScroll!.dx + _halfOfWidthScroll;
    double delta = details.globalPosition.dx - _dragStartPosition;
    if (details.globalPosition.dx > _dragStartPosition + _scrollWidth * 2) {
      delta = _scrollWidth * 2;
    }
    if (details.globalPosition.dx < _dragStartPosition - _scrollWidth * 2) {
      delta = -_scrollWidth * 2;
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
      setState(() => _scrollHeight = widget.scrollHeightOnHover);

  void _onExitScroll(PointerExitEvent event) => setState(() => _scrollHeight = widget.scrollHeight);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerSignal: _onScroll,
        child: GestureDetector(
          onHorizontalDragStart: _onTapToScrollBar,
          child: Container(
            height: widget.scrollHeightOnHover,
            width: _maxScroll,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.onBackground,
              border: Border(
                top: BorderSide(
                  color: TekColors.greyOpacity04,
                  width: 0,
                ),
                right: BorderSide(
                  color: TekColors.greyOpacity04,
                  width: 0,
                ),
                left: BorderSide(
                  color: TekColors.greyOpacity04,
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
                  left: _currentPosition,
                  child: GestureDetector(
                    onHorizontalDragStart: _startDrag,
                    onHorizontalDragUpdate: _onDrag,
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
                          color: TekColors.greyOpacity04,
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
