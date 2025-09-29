mixin LoadingMixin {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showLoading() => _isLoading = true;
  void hideLoading() => _isLoading = false;
}
