import 'package:flutter/material.dart';
import '../../domain/entities/app_language.dart';
import '../../domain/usecases/change_language_usecase.dart';

class SettingsProvider extends ChangeNotifier {
  final ChangeLanguageUseCase _changeLanguageUseCase;

  Locale _appLocale = const Locale('ar', 'SA');
  Locale get appLocale => _appLocale;
  Locale get locale => _appLocale;

  SettingsProvider({required ChangeLanguageUseCase changeLanguageUseCase})
      // ignore: prefer_initializing_formals
      : _changeLanguageUseCase = changeLanguageUseCase;

  Future<void> changeLanguage(Locale newLocale) async {
    _appLocale = newLocale;
    await _changeLanguageUseCase.execute(newLocale);
    notifyListeners();
  }

  Future<void> updateLanguage(AppLanguage language) async {
    await changeLanguage(language.locale);
  }
}

