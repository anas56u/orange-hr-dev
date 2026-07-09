import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/app_theme_mode.dart';

class ThemeLocalDataSource {
  final SharedPreferences _prefs;

  static const _themeKey = 'app_theme_mode';

  ThemeLocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  AppThemeMode getTheme() {
    final stored = _prefs.getString(_themeKey);
    return AppThemeMode.fromStorageKey(stored);
  }

  Future<void> saveTheme(AppThemeMode mode) async {
    await _prefs.setString(_themeKey, mode.toStorageKey());
  }
}