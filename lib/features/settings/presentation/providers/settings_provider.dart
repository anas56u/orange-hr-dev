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

  /// The user-selected locale. Starts as null (meaning: use whatever
  /// EasyLocalization has from its own persistence). Once the user
  /// explicitly changes the language, this is set and becomes the
  /// source of truth.
  Locale? _locale;
  Locale get locale => _locale ?? const Locale('en', 'US');

  SettingsProvider({required ChangeLanguageUseCase changeLanguageUseCase})
      // ignore: prefer_initializing_formals
      : _changeLanguageUseCase = changeLanguageUseCase;

  /// Changes the app language state and persists the choice:
  ///
  /// 1. Persists the choice via the domain layer.
  /// 2. Updates [_locale] and calls [notifyListeners], keeping
  ///    our state in sync with the app's selected language.
  Future<void> updateLanguage(AppLanguage language) async {
    // Persist the choice via the domain layer.
    await _changeLanguageUseCase.execute(language.locale);

    // Update our state and notify listeners.
    _locale = language.locale;
    notifyListeners();
  }
}

