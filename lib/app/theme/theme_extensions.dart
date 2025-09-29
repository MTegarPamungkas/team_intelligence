import 'package:flutter/material.dart';

class AppThemeExtensions extends ThemeExtension<AppThemeExtensions> {
  final Color customColor;

  AppThemeExtensions({required this.customColor});

  @override
  ThemeExtension<AppThemeExtensions> copyWith({Color? customColor}) {
    return AppThemeExtensions(customColor: customColor ?? this.customColor);
  }

  @override
  ThemeExtension<AppThemeExtensions> lerp(
    ThemeExtension<AppThemeExtensions>? other,
    double t,
  ) {
    if (other is! AppThemeExtensions) return this;
    return AppThemeExtensions(
      customColor: Color.lerp(customColor, other.customColor, t)!,
    );
  }
}
