// ignore_for_file: prefer_initializing_formals
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/app_theme_mode.dart';

/// Handles reading/writing the theme preference to local storage.
///
/// Uses a single SharedPreferences key. The [SharedPreferences] instance
/// is injected (not fetched here) so it can be pre-initialized in main()
/// before any widget builds — making reads synchronous.
class ThemeLocalDataSource {
  final SharedPreferences _prefs;

  static const _themeKey = 'app_theme_mode';

  ThemeLocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  /// Reads the stored theme. Synchronous because SharedPreferences
  /// is already loaded into memory after getInstance().
  AppThemeMode getTheme() {
    final stored = _prefs.getString(_themeKey);
    return AppThemeMode.fromStorageKey(stored);
  }

  /// Persists the theme choice. Async because it writes to disk.
  Future<void> saveTheme(AppThemeMode mode) async {
    await _prefs.setString(_themeKey, mode.toStorageKey());
  }
}
