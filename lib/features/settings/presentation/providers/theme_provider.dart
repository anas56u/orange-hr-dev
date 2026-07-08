// ignore_for_file: prefer_initializing_formals
import 'package:flutter/material.dart';

import '../../domain/entities/app_theme_mode.dart';
import '../../domain/usecases/change_theme_usecase.dart';
import '../../domain/usecases/get_theme_usecase.dart';

/// Manages the app's theme state as a dedicated [ChangeNotifier].
///
/// WHY a separate provider instead of adding to SettingsProvider?
/// → Only widgets that listen to ThemeProvider rebuild on theme changes.
///   The SettingsProvider handles language — mixing concerns would cause
///   unnecessary rebuilds (e.g., language widgets rebuilding on theme change).
///
/// The MaterialApp watches this provider for [themeMode] and switches
/// between light/dark ThemeData accordingly.
class ThemeProvider extends ChangeNotifier {
  final GetThemeUseCase _getThemeUseCase;
  final ChangeThemeUseCase _changeThemeUseCase;

  /// The current in-memory theme mode.
  AppThemeMode _appThemeMode = AppThemeMode.system;

  ThemeProvider({
    required GetThemeUseCase getThemeUseCase,
    required ChangeThemeUseCase changeThemeUseCase,
  }) : _getThemeUseCase = getThemeUseCase,
       _changeThemeUseCase = changeThemeUseCase;

  /// Exposes the Flutter-native [ThemeMode] for MaterialApp.themeMode.
  ThemeMode get themeMode => _appThemeMode.toThemeMode();

  /// Exposes the domain-level enum for UI logic (e.g., switch state).
  AppThemeMode get appThemeMode => _appThemeMode;

  /// Whether the current effective theme is dark.
  /// Useful for toggle switches that show on/off for dark mode.
  bool get isDarkMode => _appThemeMode == AppThemeMode.dark;

  /// Hydrates the in-memory state from persisted storage.
  /// Called once during app startup, before any widget builds.
  void loadTheme() {
    _appThemeMode = _getThemeUseCase.execute();
    // No notifyListeners() here — called during creation,
    // before any listeners are attached.
  }

  /// Updates the theme preference and persists it.
  ///
  /// 1. Updates in-memory state immediately (instant UI response).
  /// 2. Notifies listeners (MaterialApp rebuilds with new themeMode).
  /// 3. Persists to disk asynchronously (fire-and-forget for UX speed).
  Future<void> changeTheme(AppThemeMode mode) async {
    if (_appThemeMode == mode) return; // No-op if unchanged.

    _appThemeMode = mode;
    notifyListeners();

    // Persist in background — UI is already updated.
    await _changeThemeUseCase.execute(mode);
  }

  /// Convenience: toggles between light and dark.
  /// If currently system, switches to dark.
  Future<void> toggleDarkMode() async {
    final newMode =
        _appThemeMode == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;
    await changeTheme(newMode);
  }
}
