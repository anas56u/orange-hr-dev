import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_directory_screen.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_details_screen.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmployeeDetailsScreen(employee: employee),
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                employee.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: appColors.avatarPlaceholder,
                  child: Icon(Icons.person, color: appColors.iconDefault),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: TextStyle(
                      color: appColors.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.position,
                    style: TextStyle(
                      color: appColors.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing icon
            Icon(
              Icons.chevron_right,
              color: appColors.secondaryText,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
