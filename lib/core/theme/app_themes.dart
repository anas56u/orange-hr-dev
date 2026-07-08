import 'package:flutter/material.dart';

import 'app_colors_extension.dart';

/// Centralized theme definitions for the Orange HR app.
///
/// Both themes share the Orange brand color (0xFFFF6D00) as the seed,
/// ensuring brand consistency across light and dark modes.
/// Custom semantic colors are provided via [AppColorsExtension].
class AppThemes {
  AppThemes._(); // Prevent instantiation.

  // ── Brand constants ──────────────────────────────────────────────
  static const Color _brandOrange = Color(0xFFFF6D00);

  // ── Light Theme Extension ────────────────────────────────────────
  static final _lightAppColors = AppColorsExtension(
    // Existing Settings colors
    settingsTileBackground: Colors.white,
    settingsTileBorder: const Color(0xFFEEEEEE),
    subtitleColor: const Color(0xFF757575),
    sectionTitleColor: const Color(0xFF757575),
    brandOrange: _brandOrange,
    // New app-wide semantic colors
    cardBackground: Colors.white,
    scaffoldBackground: Colors.white,
    primaryText: const Color(0xFF1E1E1E),
    secondaryText: const Color(0xFF757575),
    iconDefault: const Color(0xFF757575),
    dividerColor: const Color(0xFFEEEEEE),
    inputFillColor: const Color(0xFFF8F9FB),
    inputBorderColor: const Color(0xFFE0E0E0),
    shadowColor: Colors.black.withValues(alpha: 0.08),
    avatarPlaceholder: const Color(0xFFE0E0E0),
  );

  // ── Dark Theme Extension ─────────────────────────────────────────
  static final _darkAppColors = AppColorsExtension(
    // Existing Settings colors
    settingsTileBackground: const Color(0xFF1E1E1E),
    settingsTileBorder: const Color(0xFF2C2C2C),
    subtitleColor: const Color(0xFF9E9E9E),
    sectionTitleColor: const Color(0xFF9E9E9E),
    brandOrange: _brandOrange,
    // New app-wide semantic colors
    cardBackground: const Color(0xFF1E1E1E),
    scaffoldBackground: const Color(0xFF121212),
    primaryText: const Color(0xFFE0E0E0),
    secondaryText: const Color(0xFF9E9E9E),
    iconDefault: const Color(0xFF9E9E9E),
    dividerColor: const Color(0xFF2C2C2C),
    inputFillColor: const Color(0xFF1E1E1E),
    inputBorderColor: const Color(0xFF424242),
    shadowColor: Colors.black.withValues(alpha: 0.3),
    avatarPlaceholder: const Color(0xFF424242),
  );

  // ── Light ThemeData ──────────────────────────────────────────────
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandOrange,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1E1E1E),
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFEEEEEE),
      thickness: 1.0,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _brandOrange;
        return const Color(0xFFBDBDBD);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _brandOrange.withValues(alpha: 0.4);
        }
        return const Color(0xFFE0E0E0);
      }),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1E1E1E),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF1E1E1E),
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Color(0xFF757575),
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: Color(0xFF757575),
      ),
    ),
    extensions: [_lightAppColors],
  );

  // ── Dark ThemeData ───────────────────────────────────────────────
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandOrange,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Color(0xFFE0E0E0),
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2C2C2C),
      thickness: 1.0,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _brandOrange;
        return const Color(0xFF757575);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _brandOrange.withValues(alpha: 0.4);
        }
        return const Color(0xFF424242);
      }),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE0E0E0),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFE0E0E0),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFE0E0E0),
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Color(0xFF9E9E9E),
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: Color(0xFF9E9E9E),
      ),
    ),
    extensions: [_darkAppColors],
  );
}
