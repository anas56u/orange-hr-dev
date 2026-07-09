import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:orange_hr_dev/features/home/presentation/providers/home_provider.dart';
import 'package:orange_hr_dev/features/login/presentation/pages/login_screen.dart';
import 'package:orange_hr_dev/features/login/presentation/providers/login_provider.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import '../widgets/dark_mode_toggle_tile.dart';
import '../widgets/language_selector_tile.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/settings_tile_widget.dart';
import '../widgets/about_app_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale; 
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  context.tr('settings'),
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 12),

              // Preferences Section
              SettingsSectionTitle(title: context.tr('preferences')),
              ThemeSelectorTile(),
              LanguageSelectorTile(),

              // General Section
              SettingsSectionTitle(title: context.tr('general')),
              SettingsTileWidget(
                title: context.tr('about'),
                subtitle: 'Orange HR Mobile Suite',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AboutAppDialog(),
                  );
                },
              ),
              SettingsTileWidget(
                title: context.tr('app_version'),
                trailing: Text(
                  context.tr('version_number'),
                  style: TextStyle(
                    fontSize: 14,
                    color: appColors.subtitleColor,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Logout button
              SettingsTileWidget(
                title: context.tr('logout'),
                titleColor: const Color(0xFFD32F2F),
                onTap: () {
                  context.read<LoginProvider>().logout();
                  context.read<HomeProvider>().updateTabIndex(0);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
