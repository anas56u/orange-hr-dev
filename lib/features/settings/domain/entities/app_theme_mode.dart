import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
  system;

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

  String toStorageKey() => name;

  static AppThemeMode fromStorageKey(String? key) {
    if (key == null) return AppThemeMode.system;
    return AppThemeMode.values.firstWhere(
      (mode) => mode.name == key,
      orElse: () => AppThemeMode.system,
    );
  }
}