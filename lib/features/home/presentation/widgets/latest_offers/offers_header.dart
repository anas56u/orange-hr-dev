import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class OffersHeader extends StatelessWidget {
  const OffersHeader({super.key});

  static const _iconColor = Color(0xFFFF6B35);

  @override
  Widget build(BuildContext context) {
    context.locale;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: Row(
        children: [

          const Icon(Iconsax.tag5, color: _iconColor, size: 40),
          const SizedBox(width: 14),
          Text(
            'Latest Offers'.tr(),
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