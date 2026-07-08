import '../entities/app_theme_mode.dart';
import '../repositories/settings_repository.dart';

/// Use case that persists the user's chosen theme preference.
///
/// The presentation layer calls this when the user toggles the theme.
/// Persistence is async (SharedPreferences write), but the UI update
/// is immediate via the provider's in-memory state.
class ChangeThemeUseCase {
  final SettingsRepository repository;

  const ChangeThemeUseCase(this.repository);

  Future<void> execute(AppThemeMode mode) async {
    await repository.saveTheme(mode);
  }
}
