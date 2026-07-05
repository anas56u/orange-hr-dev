import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/features/login/presentation/pages/login_screen.dart';
import '../widgets/dark_mode_toggle_tile.dart';
import '../widgets/language_selector_tile.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/settings_tile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title
              const SizedBox(height: 12),
              Text(
                'settings'.tr(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E1E1E),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 20),

              // Preferences Section
              SettingsSectionTitle(title: 'preferences'.tr()),
              const DarkModeToggleTile(),
              const LanguageSelectorTile(),

              // General Section
              SettingsSectionTitle(title: 'general'.tr()),
              SettingsTileWidget(
                icon: Iconsax.info_circle,
                iconBackgroundColor: const Color(0xFF1976D2).withValues(alpha: 0.12),
                iconColor: const Color(0xFF1976D2),
                title: 'about'.tr(),
                subtitle: 'Orange HR Mobile Suite',
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Orange HR',
                    applicationVersion: '1.0.0+1',
                    applicationIcon: Image.asset(
                      'assets/images/logo.png',
                      width: 48,
                      height: 48,
                    ),
                    children: [
                      const Text('Empowering workplace excellence with Orange HR Mobile Suite.'),
                    ],
                  );
                },
              ),
              SettingsTileWidget(
                icon: Iconsax.mobile,
                iconBackgroundColor: const Color(0xFF8E24AA).withValues(alpha: 0.12),
                iconColor: const Color(0xFF8E24AA),
                title: 'app_version'.tr(),
                trailing: Text(
                  'version_number'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Logout button
              SettingsTileWidget(
                icon: Iconsax.logout,
                iconBackgroundColor: const Color(0xFFE53935).withValues(alpha: 0.12),
                iconColor: const Color(0xFFE53935),
                title: 'logout'.tr(),
                titleColor: const Color(0xFFE53935),
                trailing: const SizedBox.shrink(),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
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
