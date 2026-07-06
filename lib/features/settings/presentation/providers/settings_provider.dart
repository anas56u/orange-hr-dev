import 'package:flutter/material.dart';
import '../../domain/entities/app_language.dart';
import '../../domain/usecases/change_language_usecase.dart';

/// Provider that manages the app's locale state.
///
/// This is the SINGLE SOURCE OF TRUTH for the current locale.
/// [MaterialApp] reads [locale] via a [Consumer], so when
/// [notifyListeners] fires, the entire app rebuilds with the
/// new language — no hot reload required.
class SettingsProvider extends ChangeNotifier {
  final ChangeLanguageUseCase _changeLanguageUseCase;

  Locale _appLocale = const Locale('ar');
  Locale get appLocale => _appLocale;
  Locale get locale => _appLocale;

  SettingsProvider({required ChangeLanguageUseCase changeLanguageUseCase})
      // ignore: prefer_initializing_formals
      : _changeLanguageUseCase = changeLanguageUseCase;

  /// Changes the app language state and persists the choice:
  ///
  /// 1. Updates [_appLocale].
  /// 2. Persists the choice via the domain layer.
  /// 3. Calls [notifyListeners], keeping our state in sync with the app's UI.
  Future<void> changeLanguage(Locale newLocale) async {
    _appLocale = newLocale;
    await _changeLanguageUseCase.execute(newLocale);
    notifyListeners();
  }

  /// Changes the app language state using [AppLanguage].
  Future<void> updateLanguage(AppLanguage language) async {
    await changeLanguage(language.locale);
  }
}

