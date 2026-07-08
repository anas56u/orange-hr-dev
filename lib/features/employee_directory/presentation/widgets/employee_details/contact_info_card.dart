import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class ContactInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData actionIcon;
  final Color actionIconColor;
  final VoidCallback? onActionTap;

  const ContactInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.actionIcon,
    required this.actionIconColor,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 19.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: appColors.shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: appColors.dividerColor, width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: appColors.brandOrange,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  value,
                  style: TextStyle(
                    color: appColors.primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // --- Action Icon ---
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onActionTap,
            child: Icon(actionIcon, color: actionIconColor, size: 30),
          ),
        ],
      ),
    );
  }
}
