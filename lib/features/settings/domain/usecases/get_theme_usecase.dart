import '../entities/app_theme_mode.dart';
import '../repositories/settings_repository.dart';

/// Use case that retrieves the user's persisted theme preference.
///
/// Returns [AppThemeMode.system] if no preference has been saved yet,
/// letting the OS decide light vs dark.
class GetThemeUseCase {
  final SettingsRepository repository;

  const GetThemeUseCase(this.repository);

  AppThemeMode execute() {
    return repository.getTheme();
  }
}
