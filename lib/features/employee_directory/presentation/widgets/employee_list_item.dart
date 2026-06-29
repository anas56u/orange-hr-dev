import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_directory_screen.dart'; // Import to get Employee model

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: [
            // Avatar
            ClipOval(
              child: Image.network(
                employee.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.grey),
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.position,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E), // Grey color for position
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing icon
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
