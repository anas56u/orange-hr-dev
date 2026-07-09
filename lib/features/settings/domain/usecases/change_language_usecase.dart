import 'dart:ui';
import '../repositories/settings_repository.dart';

class ChangeLanguageUseCase {
  final SettingsRepository repository;

  const ChangeLanguageUseCase(this.repository);

  Future<void> execute(Locale locale) async {
    await repository.changeLanguage(locale);
  }
}