import 'dart:ui';

import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/theme_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {

  final ThemeLocalDataSource? _themeDataSource;

  SettingsRepositoryImpl({ThemeLocalDataSource? themeDataSource})
      : _themeDataSource = themeDataSource;

  @override
  Future<void> changeLanguage(Locale locale) async {

  }

  @override
  Locale? getCurrentLocale() {

    return null;
  }

  @override
  AppThemeMode getTheme() {

    return _themeDataSource?.getTheme() ?? AppThemeMode.system;
  }

  @override
  Future<void> saveTheme(AppThemeMode mode) async {
    await _themeDataSource?.saveTheme(mode);
  }
}