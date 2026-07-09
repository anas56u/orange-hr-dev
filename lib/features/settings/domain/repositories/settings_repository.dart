import 'dart:ui';

import '../entities/app_theme_mode.dart';

abstract class SettingsRepository {

  Future<void> changeLanguage(Locale locale);

  Locale? getCurrentLocale();

  AppThemeMode getTheme();

  Future<void> saveTheme(AppThemeMode mode);
}