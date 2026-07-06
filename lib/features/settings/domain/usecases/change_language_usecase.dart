import 'dart:ui';
import '../repositories/settings_repository.dart';

/// Use case that changes the app's language preference.
///
/// Takes a pure [Locale] — no Flutter framework dependency.
/// The presentation layer is responsible for telling EasyLocalization
/// about the change; this use case handles the persistence side.
class ChangeLanguageUseCase {
  final SettingsRepository repository;

  const ChangeLanguageUseCase(this.repository);

  Future<void> execute(Locale locale) async {
    await repository.changeLanguage(locale);
  }
}
