import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<void> changeLanguage(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  @override
  Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }
}
