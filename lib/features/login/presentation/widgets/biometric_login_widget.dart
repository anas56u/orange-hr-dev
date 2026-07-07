import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

/// A small bottom‑aligned widget showing a fingerprint icon with a
/// "Biometric Login" label. Triggers biometric authentication on tap.
class BiometricLoginWidget extends StatelessWidget {
  const BiometricLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Divider line
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
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
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
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
                  color: const Color(0xFFFFF3E0),
                  border: Border.all(
                    color: const Color(0xFFFF6D00).withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: provider.isLoadingBiometric
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Color(0xFFFF6D00),
                        ),
                      )
                    : const Icon(
                        Iconsax.finger_scan,
                        size: 28,
                        color: Color(0xFFFF6D00),
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                'biometric_login'.tr(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF546E7A),
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

