part of 'loading.dart';

class TekLoadingWrapper extends StatefulWidget {
  const TekLoadingWrapper({
    Key? key,
    required this.loadingController,
    this.child,
  }) : super(key: key);

  final Widget? child;
  final TekLoadingController loadingController;

  @override
  State<TekLoadingWrapper> createState() => _TekLoadingWrapperState();
}

class _TekLoadingWrapperState extends State<TekLoadingWrapper> {
  late final TekLoadingOverlayEntry _overlayEntry;
  late TekLoadingController _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = widget.loadingController;
    _overlayEntry = TekLoadingOverlayEntry(
      widgetBuilder: (BuildContext context) => _loadingController.w ?? Container(),
    );
    _loadingController.setCurrentOverlayEntry(_overlayEntry);
  }

  @override
  void didUpdateWidget(TekLoadingWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loadingController != widget.loadingController) {
      _loadingController = widget.loadingController;
      _overlayEntry = TekLoadingOverlayEntry(
        widgetBuilder: (BuildContext context) => _loadingController.w ?? Container(),
      );
      _loadingController.setCurrentOverlayEntry(_overlayEntry);
    }
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Overlay(
          initialEntries: [
            TekLoadingOverlayEntry(
              widgetBuilder: (BuildContext context) {
                if (widget.child != null) {
                  return widget.child!;
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            _overlayEntry,
          ],
        ),
      );
}
