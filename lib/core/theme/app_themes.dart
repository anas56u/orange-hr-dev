import 'package:flutter/material.dart';

import 'app_colors_extension.dart';

/// Centralized theme definitions for the Orange HR app.

/// Both themes share the Orange brand color (0xFFFF6D00) as the seed,
/// ensuring brand consistency across light and dark modes.
/// Custom semantic colors are provided via [AppColorsExtension].
class AppThemes {
  AppThemes._(); // Prevent instantiation.

  // ── Brand constants ──────────────────────────────────────────────
  static const Color _brandOrange = Color(0xFFFF6D00);

  // ── Light Theme Extension ────────────────────────────────────────
  static const _lightAppColors = AppColorsExtension(
    settingsTileBackground: Colors.white,
    settingsTileBorder: Color(0xFFEEEEEE),
    subtitleColor: Color(0xFF757575),
    sectionTitleColor: Color(0xFF757575),
    brandOrange: _brandOrange,
  );

  // ── Dark Theme Extension ─────────────────────────────────────────
  static const _darkAppColors = AppColorsExtension(
    settingsTileBackground: Color(0xFF1E1E1E),
    settingsTileBorder: Color(0xFF2C2C2C),
    subtitleColor: Color(0xFF9E9E9E),
    sectionTitleColor: Color(0xFF9E9E9E),
    brandOrange: _brandOrange,
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
