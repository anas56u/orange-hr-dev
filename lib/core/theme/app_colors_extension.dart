import 'package:flutter/material.dart';

/// Custom semantic colors that don't map cleanly to Material's ColorScheme.
///
/// Registered as a [ThemeExtension] in both light and dark ThemeData,
/// so widgets access them via:
///   `Theme.of(context).extension<AppColorsExtension>()!.settingsTileBackground`
///
/// This eliminates ternary operators like `isDark ? X : Y` in the UI.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  // ── Existing Settings colors ──────────────────────────────────────

  /// Background for settings list tiles.
  final Color settingsTileBackground;

  /// Border/divider color for settings tiles.
  final Color settingsTileBorder;

  /// Secondary text (subtitles, descriptions) in settings.
  final Color subtitleColor;

  /// Section header text in settings.
  final Color sectionTitleColor;

  /// The Orange HR brand accent — constant across themes.
  final Color brandOrange;

  // ── New App-wide semantic colors ──────────────────────────────────

  /// General card/tile/container background across all features.
  final Color cardBackground;

  /// Default scaffold background for screens that set it explicitly.
  final Color scaffoldBackground;

  /// Primary text color — headings, titles, main content.
  final Color primaryText;

  /// Secondary text — hints, timestamps, subtitles outside settings.
  final Color secondaryText;

  /// Default icon color for non-branded icons.
  final Color iconDefault;

  /// Divider and subtle border color across all features.
  final Color dividerColor;

  /// TextField fill/background color.
  final Color inputFillColor;

  /// TextField border color (enabled state).
  final Color inputBorderColor;

  /// Box shadow color for elevated cards and containers.
  final Color shadowColor;

  /// Avatar fallback/placeholder background.
  final Color avatarPlaceholder;

  const AppColorsExtension({
    // Existing
    required this.settingsTileBackground,
    required this.settingsTileBorder,
    required this.subtitleColor,
    required this.sectionTitleColor,
    required this.brandOrange,
    // New
    required this.cardBackground,
    required this.scaffoldBackground,
    required this.primaryText,
    required this.secondaryText,
    required this.iconDefault,
    required this.dividerColor,
    required this.inputFillColor,
    required this.inputBorderColor,
    required this.shadowColor,
    required this.avatarPlaceholder,
  });

  @override
  AppColorsExtension copyWith({
    Color? settingsTileBackground,
    Color? settingsTileBorder,
    Color? subtitleColor,
    Color? sectionTitleColor,
    Color? brandOrange,
    Color? cardBackground,
    Color? scaffoldBackground,
    Color? primaryText,
    Color? secondaryText,
    Color? iconDefault,
    Color? dividerColor,
    Color? inputFillColor,
    Color? inputBorderColor,
    Color? shadowColor,
    Color? avatarPlaceholder,
  }) {
    return AppColorsExtension(
      settingsTileBackground:
          settingsTileBackground ?? this.settingsTileBackground,
      settingsTileBorder: settingsTileBorder ?? this.settingsTileBorder,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      sectionTitleColor: sectionTitleColor ?? this.sectionTitleColor,
      brandOrange: brandOrange ?? this.brandOrange,
      cardBackground: cardBackground ?? this.cardBackground,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      iconDefault: iconDefault ?? this.iconDefault,
      dividerColor: dividerColor ?? this.dividerColor,
      inputFillColor: inputFillColor ?? this.inputFillColor,
      inputBorderColor: inputBorderColor ?? this.inputBorderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      avatarPlaceholder: avatarPlaceholder ?? this.avatarPlaceholder,
    );
  }

  /// Interpolates between two [AppColorsExtension]s for animated transitions.
  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      settingsTileBackground:
          Color.lerp(settingsTileBackground, other.settingsTileBackground, t)!,
      settingsTileBorder:
          Color.lerp(settingsTileBorder, other.settingsTileBorder, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      sectionTitleColor:
          Color.lerp(sectionTitleColor, other.sectionTitleColor, t)!,
      brandOrange: Color.lerp(brandOrange, other.brandOrange, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      inputFillColor: Color.lerp(inputFillColor, other.inputFillColor, t)!,
      inputBorderColor:
          Color.lerp(inputBorderColor, other.inputBorderColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      avatarPlaceholder:
          Color.lerp(avatarPlaceholder, other.avatarPlaceholder, t)!,
    );
  }
}
