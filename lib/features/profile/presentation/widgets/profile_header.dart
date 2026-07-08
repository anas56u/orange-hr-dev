import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String jobTitle;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.jobTitle,
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
              width: 100,
              height: 100,
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
        // --- Name ---
        Text(
          name,
          style: TextStyle(
            color: appColors.brandOrange,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4),
        // --- Job Title ---
        Text(
          jobTitle,
          style: TextStyle(
            color: appColors.primaryText,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
