import 'package:flutter/material.dart';
import '../repositories/settings_repository.dart';

class ChangeLanguageUseCase {
  final SettingsRepository repository;

  ChangeLanguageUseCase(this.repository);

  Future<void> execute(BuildContext context, Locale locale) async {
    await repository.changeLanguage(context, locale);
  }
}
