import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActionCategory {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;

  const ActionCategory({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.textColor,
  });
}

const List<ActionCategory> _mockCategories = [
  ActionCategory(
    title: 'Approval\nCenter',
    icon: Icons.check_circle,
    iconColor: Colors.white,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  ),
  ActionCategory(
    title: 'Attendance\n& Overtime',
    icon: Iconsax.timer_15,
    iconColor: Color(0xFFA67BC5),
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Document\nCenter',
    icon: Iconsax.document_copy5,
    iconColor: Color(0xFF65B4E3),
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Health\nInsurance',
    icon: Iconsax.heart5,
    iconColor: Color(0xFFF396D1),
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),

  // ✅ الجديدة
  ActionCategory(
    title: 'Objectives\n& Appraisal',
    icon: Iconsax.award, // 🏅 أو جرب Iconsax.award5
    iconColor: Color(0xFF4CAF50),
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Employee\nBenefits',
    icon: Iconsax.gift5,
    iconColor: Color(0xFFFFC107), // أصفر
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Internal\nCommunication',
    icon: Iconsax.message5,
    iconColor: Color(0xFFFF6B35), // برتقالي
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Jobs\n& Recruitment',
    icon: Iconsax.people5,
    iconColor: Color(0xFF607D8B), // رمادي
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Training\n& Certificates',
    icon: Iconsax.teacher5,
    iconColor: Color(0xFF29B6F6), // أزرق
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
  ActionCategory(
    title: 'Latest\nOffers',
    icon: Iconsax.tag5,
    iconColor: Color(0xFFFF6B35), // برتقالي
    backgroundColor: Colors.white,
    textColor: Colors.black,
  ),
];
// -----------------

class HomeActionsGrid extends StatelessWidget {
  const HomeActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: GridView.builder(
        itemCount: _mockCategories.length,
        shrinkWrap: true, // Important for placing inside SingleChildScrollView
        physics:
            const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0, // Square cards
        ),
        itemBuilder: (context, index) {
          final category = _mockCategories[index];
          return ActionCardWidget(category: category);
        },
      ),
    );
  }
}

class ActionCardWidget extends StatelessWidget {
  final ActionCategory category;

  const ActionCardWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: category.backgroundColor == Colors.black
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(category.icon, color: category.iconColor, size: 40.0),
          const SizedBox(height: 29),
          Text(
            category.title,
            style: TextStyle(
              color: category.textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
