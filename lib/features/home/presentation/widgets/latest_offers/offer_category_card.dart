import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import '../../../domain/entities/offer_category.dart';

class OfferCategoryCard extends StatelessWidget {
  final OfferCategory category;
  final VoidCallback? onTap;

  const OfferCategoryCard({super.key, required this.category, this.onTap});

  static const _cardRadius = 20.0;

  static const _emojiStyle = TextStyle(fontSize: 52);

  static const _cardPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    context.locale;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: appColors.shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(_cardRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(_cardRadius),
          onTap: onTap,
          child: Padding(
            padding: _cardPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(category.emoji, style: _emojiStyle),
                const SizedBox(height: 14),

                Text(
                  category.title.tr(),
                  textAlign: TextAlign.center,

                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: appColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}