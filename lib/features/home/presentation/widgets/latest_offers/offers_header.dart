import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

/// Header widget for the Latest Offers screen.
class OffersHeader extends StatelessWidget {
  const OffersHeader({super.key});

  // Pre-defined constants to avoid per-frame allocations.
  static const _iconColor = Color(0xFFFF6B35);

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: Row(
        children: [
          // Orange tag icon — same icon & color used on the home grid tile.
          const Icon(Iconsax.tag5, color: _iconColor, size: 40),
          const SizedBox(width: 14),
          Text(
            'Latest Offers',
            style: TextStyle(
              color: appColors.primaryText,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
