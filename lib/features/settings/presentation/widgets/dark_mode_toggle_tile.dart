import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/settings/domain/entities/app_theme_mode.dart';
import 'package:orange_hr_dev/features/settings/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class DarkModeToggleTile extends StatelessWidget {
  const DarkModeToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale; 

    final isDarkMode = context.select<ThemeProvider, bool>((p) => p.isDarkMode);
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return Container(
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
                  context.tr('dark_mode'),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  context.tr('dark_mode_desc'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isDarkMode,
            activeTrackColor: appColors.brandOrange,
            onChanged: (value) {
              context.read<ThemeProvider>().changeTheme(
                value ? AppThemeMode.dark : AppThemeMode.light,
              );
            },
          ),
        ],
      ),
    );
  }
}
