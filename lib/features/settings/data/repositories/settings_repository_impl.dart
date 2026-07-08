// ignore_for_file: prefer_initializing_formals
import 'dart:ui';

import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/theme_local_data_source.dart';

/// Concrete implementation of [SettingsRepository].
///
/// Bridges the domain contracts to actual data sources.
/// Theme persistence is delegated to [ThemeLocalDataSource];
/// language persistence is still a stub (TODO).
class SettingsRepositoryImpl implements SettingsRepository {
  /// Nullable because existing code constructs this without a data source.
  /// Once the full DI is wired, this should become required.
  final ThemeLocalDataSource? _themeDataSource;

  SettingsRepositoryImpl({ThemeLocalDataSource? themeDataSource})
      : _themeDataSource = themeDataSource;

  // ---------------------------------------------------------------------------
  // Language (existing — unchanged)
  // ---------------------------------------------------------------------------

  @override
  Future<void> changeLanguage(Locale locale) async {
    // TODO: Persist to SharedPreferences.
  }

  @override
  Locale? getCurrentLocale() {
    // TODO: Read from SharedPreferences.
    return null;
  }

  // ---------------------------------------------------------------------------
  // Theme
  // ---------------------------------------------------------------------------

  @override
  AppThemeMode getTheme() {
    // Falls back to system if data source isn't available.
    return _themeDataSource?.getTheme() ?? AppThemeMode.system;
  }

  @override
  Future<void> saveTheme(AppThemeMode mode) async {
    await _themeDataSource?.saveTheme(mode);
  }
}
