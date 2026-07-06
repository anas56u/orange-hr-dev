import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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

  /// Changes the app language. Two things happen:
  ///
  /// 1. `context.setLocale()` tells EasyLocalization to load
  ///    the new translation strings (e.g., ar.json).
  /// 2. We update [_locale] and call [notifyListeners], which
  ///    triggers the [Consumer] in main.dart to rebuild
  ///    [MaterialApp] with the new locale.
  Future<void> updateLanguage(BuildContext context, AppLanguage language) async {
    // Tell EasyLocalization to swap the translation strings.
    await context.setLocale(language.locale);

    // Persist the choice via the domain layer.
    await _changeLanguageUseCase.execute(language.locale);

    // Update our state and notify listeners.
    // The Consumer<SettingsProvider> in main.dart will rebuild
    // MaterialApp with this new locale value.
    _locale = language.locale;
    notifyListeners();
  }
}
