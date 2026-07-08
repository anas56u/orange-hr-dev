import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

/// Reusable tile widget for a sub-action item within a category.
///
/// Matches the existing design system: rounded border, title text,
/// trailing chevron — identical to [MenuOptionTile] in the profile feature.
class CategoryActionTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CategoryActionTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    context.locale; // Subscribe to locale changes
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: appColors.shadowColor,
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            color: appColors.cardBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: appColors.dividerColor, width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.tr(title),
                  style: TextStyle(
                    color: appColors.primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: appColors.secondaryText, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
