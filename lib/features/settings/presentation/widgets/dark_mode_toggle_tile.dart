import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/settings/domain/entities/app_theme_mode.dart';
import 'package:orange_hr_dev/features/settings/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSelectorTile extends StatelessWidget {
  const ThemeSelectorTile({super.key});

  String _getThemeModeName(BuildContext context, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return context.tr('theme_light');
      case AppThemeMode.dark:
        return context.tr('theme_dark');
      case AppThemeMode.system:
        return context.tr('theme_system');
    }
  }

  void _showThemeBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: appColors.settingsTileBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        final currentMode = context.read<ThemeProvider>().appThemeMode;
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
                  context.tr('theme'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  context.tr('theme_desc'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.subtitleColor,
                  ),
                ),
                const SizedBox(height: 16),
                ...AppThemeMode.values.map((mode) {
                  final isSelected = mode == currentMode;
                  return InkWell(
                    onTap: () {
                      Navigator.pop(bottomSheetContext);
                      context.read<ThemeProvider>().changeTheme(mode);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: appColors.settingsTileBorder,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getThemeModeName(context, mode),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w400,
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
    context.locale;
    final currentMode =
        context.select<ThemeProvider, AppThemeMode>((p) => p.appThemeMode);
    final currentName = _getThemeModeName(context, currentMode);
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return InkWell(
      onTap: () => _showThemeBottomSheet(context),
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
                    context.tr('theme'),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('theme_desc'),
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

/// Backward-compatibility alias so existing imports keep working.
typedef DarkModeToggleTile = ThemeSelectorTile;
