import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

/// A tappable menu row with a label and a trailing chevron,
/// inside a rounded bordered container — used for "My Qualification"
/// and any future menu items on the profile screen.
class MenuOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const MenuOptionTile({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: appColors.dividerColor,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: appColors.primaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: appColors.secondaryText,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
