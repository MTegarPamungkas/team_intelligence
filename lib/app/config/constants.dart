class AppConstants {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool isStaging = bool.fromEnvironment('dart.vm.staging');
}
