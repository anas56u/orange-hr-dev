import 'dart:ui';

/// Abstract contract for settings persistence.
///
/// The domain layer depends on this abstraction — the data layer
/// provides the concrete implementation (e.g., SharedPreferences).
///
/// NOTE: No Flutter framework imports allowed here. We use 'dart:ui'
/// for the [Locale] type, which is a pure Dart class.
abstract class SettingsRepository {
  /// Persists the user's language preference.
  Future<void> changeLanguage(Locale locale);

  /// Retrieves the previously persisted locale, if any.
  Locale? getCurrentLocale();
}
