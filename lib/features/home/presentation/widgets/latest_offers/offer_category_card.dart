import 'package:flutter/material.dart';
import '../../../domain/entities/offer_category.dart';

/// A tappable card widget displaying a single offer category.
///
/// Renders the category's emoji illustration centered above the title,
/// inside a white rounded card with a subtle shadow — matching the
/// design exactly. Uses [InkWell] for a native ripple effect.
///
/// All static layout constants (padding, decoration, text style) are
/// declared as `const` or `static const` to minimize rebuild cost.
class OfferCategoryCard extends StatelessWidget {
  final OfferCategory category;
  final VoidCallback? onTap;

  const OfferCategoryCard({super.key, required this.category, this.onTap});


  static const _cardRadius = 20.0;

  static const _emojiStyle = TextStyle(fontSize: 52);

  static const _titleStyle = TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.35,
  );

  static const _cardPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                // Emoji illustration — renders as full-color graphics
                // on both Android and iOS.
                Text(category.emoji, style: _emojiStyle),
                const SizedBox(height: 14),
                // Category title — centered, multi-line.
                Text(
                  category.title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: _titleStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
