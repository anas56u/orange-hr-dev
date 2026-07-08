import 'package:flutter/material.dart';

/// Custom semantic colors that don't map cleanly to Material's ColorScheme.
///
/// Registered as a [ThemeExtension] in both light and dark ThemeData,
/// so widgets access them via:
///   `Theme.of(context).extension<AppColorsExtension>()!.settingsTileBackground`
///
/// This eliminates ternary operators like `isDark ? X : Y` in the UI.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  /// Background for settings list tiles.
  final Color settingsTileBackground;

  /// Border/divider color for settings tiles.
  final Color settingsTileBorder;

  /// Secondary text (subtitles, descriptions).
  final Color subtitleColor;

  /// Section header text in settings.
  final Color sectionTitleColor;

  /// The Orange HR brand accent — constant across themes.
  final Color brandOrange;

  const AppColorsExtension({
    required this.settingsTileBackground,
    required this.settingsTileBorder,
    required this.subtitleColor,
    required this.sectionTitleColor,
    required this.brandOrange,
  });

  /// Interpolates between two [AppColorsExtension]s for animated transitions.
  @override
  AppColorsExtension copyWith({
    Color? settingsTileBackground,
    Color? settingsTileBorder,
    Color? subtitleColor,
    Color? sectionTitleColor,
    Color? brandOrange,
  }) {
    return AppColorsExtension(
      settingsTileBackground:
          settingsTileBackground ?? this.settingsTileBackground,
      settingsTileBorder: settingsTileBorder ?? this.settingsTileBorder,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      sectionTitleColor: sectionTitleColor ?? this.sectionTitleColor,
      brandOrange: brandOrange ?? this.brandOrange,
    );
  }

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
    );
  }
}
