import '../entities/app_theme_mode.dart';
import '../repositories/settings_repository.dart';

class GetThemeUseCase {
  final SettingsRepository repository;

  const GetThemeUseCase(this.repository);

  AppThemeMode execute() {
    return repository.getTheme();
  }
}