import 'package:flutter/material.dart';

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
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black54,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
