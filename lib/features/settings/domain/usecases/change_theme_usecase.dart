import '../entities/app_theme_mode.dart';
import '../repositories/settings_repository.dart';

class ChangeThemeUseCase {
  final SettingsRepository repository;

  const ChangeThemeUseCase(this.repository);

  Future<void> execute(AppThemeMode mode) async {
    await repository.saveTheme(mode);
  }
}