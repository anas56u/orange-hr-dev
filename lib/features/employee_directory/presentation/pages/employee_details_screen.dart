import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_directory_screen.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/employee_avatar_section.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/contact_info_card.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/info_field.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/back_action_button.dart';

/// Full-screen Employee Details page.
///
/// Accepts an [Employee] via its constructor — all data is passed from
/// the list screen, keeping this widget stateless and fast to render.
class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // --- Avatar + Name + Position (centered) ---
            Center(
              child: EmployeeAvatarSection(
                imageUrl: employee.imageUrl,
                name: employee.name,
                position: employee.position,
              ),
            ),

            const SizedBox(height: 28),

            // --- Email Card ---
            ContactInfoCard(
              label: 'Email:',
              value: employee.email,
              actionIcon: Icons.mail,
              actionIconColor: const Color(0xFF4FC3F7), // Light blue
            ),

            const SizedBox(height: 14),

            // --- Mobile Card ---
            ContactInfoCard(
              label: 'Mobile:',
              value: employee.mobile,
              actionIcon: Icons.phone,
              actionIconColor: const Color(0xFF66BB6A), // Green
            ),

            const SizedBox(height: 24),

            // --- Unit ---
            InfoField(label: 'Unit', value: employee.unit),

            const SizedBox(height: 20),

            // --- Organization ---
            InfoField(label: 'Organization', value: employee.organization),

            const SizedBox(height: 20),

            // --- Address ---
            InfoField(label: 'Address:', value: employee.address),

            const SizedBox(height: 38),

            // --- Back Button ---
            const BackActionButton(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
