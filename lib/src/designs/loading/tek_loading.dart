part of 'loading.dart';

class TekLoading {
  TekLoading._privateConstructor();

  static final TekLoading _instance = TekLoading._privateConstructor();

  factory TekLoading() => _instance;

  static final TekLoadingController appLoading = TekLoadingController();

  String _defaultLoadingText = 'Loading...';

  void setDefaultLoadingText(String text) => _defaultLoadingText = text;

  get defaultLoadingText => _defaultLoadingText;
}