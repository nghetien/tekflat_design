part of 'loading.dart';

class TekLoadingController {
  bool _statusLoading = false;

  void setStatusLoading(bool status) => _statusLoading = status;

  bool get statusLoading => _statusLoading;

  Widget initLoading(BuildContext context, Widget? child) =>
      TekLoadingWrapper(
        loadingController: this,
        child: child,
      );

  Widget _defaultW = Builder(
    builder: (BuildContext context) =>
        Container(
          decoration: BoxDecoration(
            borderRadius: TekCorners().mainCornerBorder,
            color: context.theme.colorScheme.background.withOpacity(0.65),
          ),
          child: const TekLoadingWidget(),
        ),
  );

  Widget get defaultW => _defaultW;

  void setDefaultW(Widget widget) => _defaultW = widget;

  Widget? _w;

  Widget? get w => _w;

  void setW(Widget? widget) => _w = widget;

  TekLoadingOverlayEntry? _currentOverlayEntry;

  TekLoadingOverlayEntry? get currentOverlayEntry => _currentOverlayEntry;

  void setCurrentOverlayEntry(TekLoadingOverlayEntry? overlayEntry) =>
      _currentOverlayEntry = overlayEntry;

  void _markNeedsBuild() => currentOverlayEntry?.markNeedsBuild();

  void show() {
    if (statusLoading) return;
    setStatusLoading(true);
    setW(_defaultW);
    _markNeedsBuild();
  }

  void dismiss() {
    if (!statusLoading) return;
    setStatusLoading(false);
    setW(null);
    _markNeedsBuild();
  }

  Future<T?> openAndDismissLoading<T>(
    AsyncValueGetter<T?> callback, {
    Function(dynamic)? onError,
  }) async {
    try {
      show();
      final T? result = await callback();
      dismiss();
      return result;
    } catch (e) {
      TekLogger.debugLog('openAndDismissLoading: $e');
      if (onError != null) onError(e);
      dismiss();
    }
    return null;
  }
}
