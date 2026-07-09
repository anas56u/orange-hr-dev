import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: appColors.dividerColor,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: appColors.shadowColor,
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: appColors.brandOrange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Orange HR',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: appColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: appColors.brandOrange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Mobile Suite • v1.0.0+1',
                style: TextStyle(
                  color: appColors.brandOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 18),

            Text(
              'Empowering workplace excellence with Orange HR Mobile Suite. Seamlessly manage attendance, leave requests, approvals, and employee services anytime, anywhere.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.secondaryText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.brandOrange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}