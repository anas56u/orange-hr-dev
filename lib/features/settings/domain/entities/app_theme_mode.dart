import 'package:flutter/material.dart';

/// Represents the user's theme preference.
///
/// Maps 1:1 to Flutter's [ThemeMode] but lives in the domain layer
/// so it has no framework dependency beyond the enum itself.
/// Includes serialization helpers for persistence.
enum AppThemeMode {
  light,
  dark,
  system;

  /// Converts to Flutter's [ThemeMode] for use in [MaterialApp.themeMode].
  ThemeMode toThemeMode() {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Serializes to a string for SharedPreferences storage.
  String toStorageKey() => name;

  /// Deserializes from a stored string, falling back to [system].
  static AppThemeMode fromStorageKey(String? key) {
    if (key == null) return AppThemeMode.system;
    return AppThemeMode.values.firstWhere(
      (mode) => mode.name == key,
      orElse: () => AppThemeMode.system,
    );
  }
}
