import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<void> changeLanguage(BuildContext context, Locale locale);
  Locale getCurrentLocale(BuildContext context);
}
