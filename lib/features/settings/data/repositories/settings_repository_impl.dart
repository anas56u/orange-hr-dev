import 'dart:ui';
import '../../domain/repositories/settings_repository.dart';

/// Concrete implementation of [SettingsRepository].
///
/// Responsible for **persisting** the user's locale preference.
/// Currently a stub — ready for SharedPreferences integration.
///
/// IMPORTANT: This class does NOT call context.setLocale().
/// That's a presentation-layer concern handled by [SettingsProvider].
class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<void> changeLanguage(Locale locale) async {
    // TODO: Persist to SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('locale_language', locale.languageCode);
    // await prefs.setString('locale_country', locale.countryCode ?? '');
  }

  @override
  Locale? getCurrentLocale() {
    // TODO: Read from SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // final lang = prefs.getString('locale_language');
    // if (lang == null) return null;
    // final country = prefs.getString('locale_country');
    // return Locale(lang, country);
    return null;
  }
}
