import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

import '../providers/login_provider.dart';

/// A small bottom‑aligned widget showing a fingerprint icon with a
/// "Biometric Login" label. Triggers biometric authentication on tap.
class BiometricLoginWidget extends StatelessWidget {
  const BiometricLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Divider line
        Row(
          children: [
            Expanded(
              child: Divider(
                color: appColors.dividerColor,
                thickness: 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or'.tr(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: appColors.secondaryText,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: appColors.dividerColor,
                thickness: 0.8,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Biometric button
        GestureDetector(
          onTap: provider.isLoadingBiometric
              ? null
              : () => provider.authenticateWithBiometric(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.brandOrange.withValues(alpha: 0.12),
                  border: Border.all(
                    color: appColors.brandOrange.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: provider.isLoadingBiometric
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: appColors.brandOrange,
                        ),
                      )
                    : Icon(
                        Iconsax.finger_scan,
                        size: 28,
                        color: appColors.brandOrange,
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                'biometric_login'.tr(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: appColors.secondaryText,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

