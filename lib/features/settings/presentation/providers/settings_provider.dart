// ignore_for_file: prefer_initializing_formals
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../domain/entities/app_language.dart';
import '../../domain/usecases/change_language_usecase.dart';

class SettingsProvider extends ChangeNotifier {
  final ChangeLanguageUseCase _changeLanguageUseCase;

  AppLanguage _selectedLanguage = AppLanguage.system;
  AppLanguage get selectedLanguage => _selectedLanguage;

  Locale _appLocale = const Locale('ar', 'SA');
  Locale get appLocale => _appLocale;
  Locale get locale => _appLocale;

  SettingsProvider({required ChangeLanguageUseCase changeLanguageUseCase})
      : _changeLanguageUseCase = changeLanguageUseCase;

  Future<void> changeLanguage(Locale newLocale) async {
    _appLocale = newLocale;
    _selectedLanguage = AppLanguage.fromLocale(newLocale);
    await _changeLanguageUseCase.execute(newLocale);
    notifyListeners();
  }

  Future<void> updateLanguage(AppLanguage language) async {
    _selectedLanguage = language;
    if (language.locale != null) {
      await changeLanguage(language.locale!);
    } else {
      notifyListeners();
    }
  }

  Future<void> setLanguageMode(BuildContext context, AppLanguage language) async {
    _selectedLanguage = language;
    notifyListeners();

    if (language == AppLanguage.system) {
      await context.resetLocale();
    } else if (language.locale != null) {
      await context.setLocale(language.locale!);
      _appLocale = language.locale!;
      await _changeLanguageUseCase.execute(language.locale!);
    }
  }
}
