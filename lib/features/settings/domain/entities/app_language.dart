import 'package:flutter/material.dart';

enum AppLanguage {
  system(null, null, 'System Default', 'System Flag'),
  english('en', 'US', 'English', 'US Flag'),
  arabic('ar', 'SA', 'العربية', 'SA Flag');

  final String? languageCode;
  final String? countryCode;
  final String displayName;
  final String flagDescription;

  const AppLanguage(
    this.languageCode,
    this.countryCode,
    this.displayName,
    this.flagDescription,
  );

  Locale? get locale =>
      languageCode != null && countryCode != null
          ? Locale(languageCode!, countryCode!)
          : null;

  static AppLanguage fromLocale(Locale? locale) {
    if (locale == null) return AppLanguage.system;
    if (locale.languageCode == 'ar') {
      return AppLanguage.arabic;
    }
    return AppLanguage.english;
  }
}
