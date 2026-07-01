import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Header widget for the Latest Offers screen.
class OffersHeader extends StatelessWidget {
  const OffersHeader({super.key});

  // Pre-defined constants to avoid per-frame allocations.
  static const _iconColor = Color(0xFFFF6B35);

  static const _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: Row(
        children: [
          // Orange tag icon — same icon & color used on the home grid tile.
          Icon(Iconsax.tag5, color: _iconColor, size: 40),
          SizedBox(width: 14),
          Text('Latest Offers', style: _titleStyle),
        ],
      ),
    );
  }
}
