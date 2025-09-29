import 'package:flutter/material.dart';

class AppColorScheme {
  // Light Theme Colors - Professional Blue-Grey Palette
  static const Color lightPrimary = Color(0xFF1565C0); // Professional Blue
  static const Color lightOnPrimary = Color(0xFFFFFFFF); // White
  static const Color lightPrimaryContainer = Color(0xFFE3F2FD); // Light Blue
  static const Color lightOnPrimaryContainer = Color(0xFF0D47A1); // Dark Blue
  static const Color lightSecondary = Color(0xFF37474F); // Blue Grey
  static const Color lightOnSecondary = Color(0xFFFFFFFF); // White
  static const Color lightSecondaryContainer = Color(
    0xFFECEFF1,
  ); // Light Blue Grey
  static const Color lightOnSecondaryContainer = Color(
    0xFF263238,
  ); // Dark Blue Grey
  static const Color lightTertiary = Color(0xFF00695C); // Professional Teal
  static const Color lightOnTertiary = Color(0xFFFFFFFF); // White
  static const Color lightTertiaryContainer = Color(0xFFE0F2F1); // Light Teal
  static const Color lightOnTertiaryContainer = Color(0xFF004D40); // Dark Teal
  static const Color lightError = Color(0xFFD32F2F); // Professional Red
  static const Color lightOnError = Color(0xFFFFFFFF); // White
  static const Color lightErrorContainer = Color(0xFFFFEBEE); // Light Red
  static const Color lightOnErrorContainer = Color(0xFFB71C1C); // Dark Red
  static const Color lightBackground = Color(0xFFFAFAFA); // Neutral Background
  static const Color lightOnBackground = Color(0xFF212121); // Dark Text
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure White
  static const Color lightOnSurface = Color(0xFF212121); // Dark Text
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5); // Light Grey
  static const Color lightOnSurfaceVariant = Color(0xFF424242); // Medium Grey
  static const Color lightOutline = Color(0xFFBDBDBD); // Grey Border
  static const Color lightOutlineVariant = Color(0xFFE0E0E0); // Light Border
  static const Color lightShadow = Color(0xFF000000); // Black
  static const Color lightScrim = Color(0xFF000000); // Black
  static const Color lightInverseSurface = Color(0xFF303030); // Dark Surface
  static const Color lightOnInverseSurface = Color(0xFFFAFAFA); // Light Text
  static const Color lightInversePrimary = Color(0xFF90CAF9); // Light Blue
  static const Color lightSurfaceTint = Color(0xFF1565C0); // Professional Blue

  // Dark Theme Colors - Professional Dark Palette
  static const Color darkPrimary = Color(0xFF90CAF9); // Light Blue
  static const Color darkOnPrimary = Color(0xFF0D47A1); // Dark Blue
  static const Color darkPrimaryContainer = Color(0xFF1976D2); // Medium Blue
  static const Color darkOnPrimaryContainer = Color(
    0xFFE3F2FD,
  ); // Very Light Blue
  static const Color darkSecondary = Color(0xFFB0BEC5); // Light Blue Grey
  static const Color darkOnSecondary = Color(0xFF263238); // Dark Blue Grey
  static const Color darkSecondaryContainer = Color(0xFF37474F); // Blue Grey
  static const Color darkOnSecondaryContainer = Color(
    0xFFECEFF1,
  ); // Very Light Blue Grey
  static const Color darkTertiary = Color(0xFF80CBC4); // Light Teal
  static const Color darkOnTertiary = Color(0xFF004D40); // Dark Teal
  static const Color darkTertiaryContainer = Color(0xFF00695C); // Medium Teal
  static const Color darkOnTertiaryContainer = Color(
    0xFFE0F2F1,
  ); // Very Light Teal
  static const Color darkError = Color(0xFFEF9A9A); // Light Red
  static const Color darkOnError = Color(0xFFB71C1C); // Dark Red
  static const Color darkErrorContainer = Color(0xFFD32F2F); // Medium Red
  static const Color darkOnErrorContainer = Color(0xFFFFEBEE); // Very Light Red
  static const Color darkBackground = Color(
    0xFF121212,
  ); // Material Dark Background
  static const Color darkOnBackground = Color(0xFFE0E0E0); // Light Text
  static const Color darkSurface = Color(0xFF1E1E1E); // Dark Surface
  static const Color darkOnSurface = Color(0xFFE0E0E0); // Light Text
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C); // Darker Surface
  static const Color darkOnSurfaceVariant = Color(
    0xFFBDBDBD,
  ); // Light Grey Text
  static const Color darkOutline = Color(0xFF616161); // Grey Border
  static const Color darkOutlineVariant = Color(0xFF424242); // Dark Border
  static const Color darkShadow = Color(0xFF000000); // Black
  static const Color darkScrim = Color(0xFF000000); // Black
  static const Color darkInverseSurface = Color(0xFFE0E0E0); // Light Surface
  static const Color darkOnInverseSurface = Color(0xFF303030); // Dark Text
  static const Color darkInversePrimary = Color(
    0xFF1565C0,
  ); // Professional Blue
  static const Color darkSurfaceTint = Color(0xFF90CAF9); // Light Blue

  // Light ColorScheme
  static const ColorScheme lightColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    primaryContainer: lightPrimaryContainer,
    onPrimaryContainer: lightOnPrimaryContainer,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    secondaryContainer: lightSecondaryContainer,
    onSecondaryContainer: lightOnSecondaryContainer,
    tertiary: lightTertiary,
    onTertiary: lightOnTertiary,
    tertiaryContainer: lightTertiaryContainer,
    onTertiaryContainer: lightOnTertiaryContainer,
    error: lightError,
    onError: lightOnError,
    errorContainer: lightErrorContainer,
    onErrorContainer: lightOnErrorContainer,
    surfaceContainer: darkOnPrimary,
    surface: lightSurface,
    onSurface: lightOnSurface,
    surfaceContainerHighest: lightSurfaceVariant,
    onSurfaceVariant: lightOnSurfaceVariant,
    outline: lightOutline,
    outlineVariant: lightOutlineVariant,
    shadow: lightShadow,
    scrim: lightScrim,
    inverseSurface: lightInverseSurface,
    onInverseSurface: lightOnInverseSurface,
    inversePrimary: lightInversePrimary,
    surfaceTint: lightSurfaceTint,
  );

  // Dark ColorScheme
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    primaryContainer: darkPrimaryContainer,
    onPrimaryContainer: darkOnPrimaryContainer,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    secondaryContainer: darkSecondaryContainer,
    onSecondaryContainer: darkOnSecondaryContainer,
    tertiary: darkTertiary,
    onTertiary: darkOnTertiary,
    tertiaryContainer: darkTertiaryContainer,
    onTertiaryContainer: darkOnTertiaryContainer,
    error: darkError,
    onError: darkOnError,
    errorContainer: darkErrorContainer,
    onErrorContainer: darkOnErrorContainer,
    surfaceContainer: darkSurface,
    surface: darkSurface,
    onSurface: darkOnSurface,
    surfaceContainerHighest: darkSurfaceVariant,
    onSurfaceVariant: darkOnSurfaceVariant,
    outline: darkOutline,
    outlineVariant: darkOutlineVariant,
    shadow: darkShadow,
    scrim: darkScrim,
    inverseSurface: darkInverseSurface,
    onInverseSurface: darkOnInverseSurface,
    inversePrimary: darkInversePrimary,
    surfaceTint: darkSurfaceTint,
  );
}
