import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {

  final Color settingsTileBackground;

  final Color settingsTileBorder;

  final Color subtitleColor;

  final Color sectionTitleColor;

  final Color brandOrange;

  final Color cardBackground;

  final Color scaffoldBackground;

  final Color primaryText;

  final Color secondaryText;

  final Color iconDefault;

  final Color dividerColor;

  final Color inputFillColor;

  final Color inputBorderColor;

  final Color shadowColor;

  final Color avatarPlaceholder;

  const AppColorsExtension({

    required this.settingsTileBackground,
    required this.settingsTileBorder,
    required this.subtitleColor,
    required this.sectionTitleColor,
    required this.brandOrange,

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