import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

/// Displays the employee's circular avatar with an orange border,
/// name in orange, and position underneath.
class EmployeeAvatarSection extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String position;

  const EmployeeAvatarSection({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: appColors.avatarPlaceholder,
                child: Icon(Icons.person, size: 48, color: appColors.iconDefault),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: TextStyle(
            color: appColors.brandOrange,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          position,
          style: TextStyle(
            color: appColors.primaryText,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
