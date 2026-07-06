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
///
/// ## Why does this provider call context.setLocale()?
///
/// `context.setLocale()` is an EasyLocalization method that updates
/// the translation engine. This is a **presentation-layer concern**
/// (it touches the widget tree), so it belongs here — not in the
/// repository or use case.
class SettingsProvider extends ChangeNotifier {
  final ChangeLanguageUseCase _changeLanguageUseCase;

  /// The current locale. [MaterialApp] reads this via a [Consumer].
  Locale _locale = const Locale('en', 'US');
  Locale get locale => _locale;

  SettingsProvider({required ChangeLanguageUseCase changeLanguageUseCase})
      // ignore: prefer_initializing_formals
      : _changeLanguageUseCase = changeLanguageUseCase;

  /// Called once at app startup to sync the provider's state
  /// with EasyLocalization's persisted locale.
  ///
  /// Without this, [_locale] would default to English even if
  /// the user previously selected Arabic.
  void initLocale(BuildContext context) {
    _locale = context.locale;
  }

  /// Changes the app language. Three things happen in order:
  ///
  /// 1. `context.setLocale()` — tells EasyLocalization to load
  ///    the new translation file (e.g., ar.json).
  /// 2. `_changeLanguageUseCase.execute()` — persists the choice
  ///    (will use SharedPreferences once implemented).
  /// 3. `notifyListeners()` — triggers a rebuild of every widget
  ///    listening to this provider (including [MaterialApp]).
  Future<void> updateLanguage(BuildContext context, AppLanguage language) async {
    // Step 1: Tell EasyLocalization to swap translations.
    // This is a presentation-layer call — it needs BuildContext.
    await context.setLocale(language.locale);

    // Step 2: Persist the choice via the domain layer.
    await _changeLanguageUseCase.execute(language.locale);

    // Step 3: Update our state and notify listeners.
    // THIS is the line that was missing before — without it,
    // MaterialApp never knew the locale changed.
    _locale = language.locale;
    notifyListeners();
  }
}
