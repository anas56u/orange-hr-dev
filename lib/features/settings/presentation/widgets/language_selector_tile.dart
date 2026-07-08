import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:provider/provider.dart';
import 'package:orange_hr_dev/features/settings/presentation/providers/settings_provider.dart';

enum AppLanguage {
  english(Locale('en', 'US')),
  arabic(Locale('ar', 'SA'));

  final Locale locale;
  const AppLanguage(this.locale);

  static AppLanguage fromLocale(Locale locale) {
    if (locale.languageCode == 'ar') {
      return AppLanguage.arabic;
    }
    return AppLanguage.english;
  }
}

class LanguageSelectorTile extends StatelessWidget {
  const LanguageSelectorTile({super.key});

  void _showLanguageBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: appColors.settingsTileBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        final currentLang = AppLanguage.fromLocale(context.locale);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: appColors.settingsTileBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.tr('language'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  context.tr('language_desc'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.subtitleColor,
                  ),
                ),
                const SizedBox(height: 16),
                ...AppLanguage.values.map((lang) {
                  final isSelected = lang == currentLang;
                  return InkWell(
                    onTap: () async {
                      Navigator.pop(bottomSheetContext);
                      final exactLocale = lang.locale;
                      await context.setLocale(exactLocale);
                      if (context.mounted) {
                        Provider.of<SettingsProvider>(context, listen: false).changeLanguage(exactLocale);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: appColors.settingsTileBorder, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lang == AppLanguage.english ? context.tr('english') : context.tr('arabic'),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? appColors.brandOrange : null,
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_rounded,
                              color: appColors.brandOrange,
                              size: 22,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = AppLanguage.fromLocale(context.locale);
    final currentName = currentLang == AppLanguage.english ? context.tr('english') : context.tr('arabic');
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return InkWell(
      onTap: () => _showLanguageBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: appColors.settingsTileBackground,
          border: Border(
            bottom: BorderSide(color: appColors.settingsTileBorder, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('language'),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('language_desc'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: appColors.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.subtitleColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: appColors.subtitleColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
