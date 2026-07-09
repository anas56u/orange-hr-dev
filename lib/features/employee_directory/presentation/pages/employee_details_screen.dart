import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_directory_screen.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/employee_avatar_section.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/contact_info_card.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/info_field.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/widgets/employee_details/back_action_button.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Center(
              child: EmployeeAvatarSection(
                imageUrl: employee.imageUrl,
                name: employee.name,
                position: employee.position,
              ),
            ),

            const SizedBox(height: 28),

            ContactInfoCard(
              label: 'Email:',
              value: employee.email,
              actionIcon: Icons.mail,
              actionIconColor: const Color(0xFF4FC3F7),
            ),

            const SizedBox(height: 14),

            ContactInfoCard(
              label: 'Mobile:',
              value: employee.mobile,
              actionIcon: Icons.phone,
              actionIconColor: const Color(0xFF66BB6A),
            ),

            const SizedBox(height: 24),

            InfoField(label: 'Unit', value: employee.unit),

            const SizedBox(height: 20),

            InfoField(label: 'Organization', value: employee.organization),

            const SizedBox(height: 20),

            InfoField(label: 'Address:', value: employee.address),

            const SizedBox(height: 38),

            const BackActionButton(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}