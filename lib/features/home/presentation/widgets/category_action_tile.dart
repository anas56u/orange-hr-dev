import 'package:flutter/material.dart';

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
                color: Colors.black.withOpacity(0.09),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
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
              const Icon(Icons.chevron_right, color: Colors.black54, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
