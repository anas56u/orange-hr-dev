import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActionCategory {
  final String title;
  final IconData icon;
  final Color iconColor;

  const ActionCategory({
    required this.title,
    required this.icon,
    required this.iconColor,
  });
}

const List<ActionCategory> _mockCategories = [
  ActionCategory(
    title: 'Approval\nCenter',
    icon: Icons.check_circle,
    iconColor: Colors.green,
  ),
  ActionCategory(
    title: 'Attendance\n& Overtime',
    icon: Iconsax.timer_15,
    iconColor: Color(0xFFA67BC5),
  ),
  ActionCategory(
    title: 'Document\nCenter',
    icon: Iconsax.document_copy5,
    iconColor: Color(0xFF65B4E3),
  ),
  ActionCategory(
    title: 'Health\nInsurance',
    icon: Iconsax.heart5,
    iconColor: Color(0xFFF396D1),
  ),

  // ✅ الجديدة
  ActionCategory(
    title: 'Objectives\n& Appraisal',
    icon: Iconsax.award, // 🏅 أو جرب Iconsax.award5
    iconColor: Color(0xFF4CAF50),
  ),
  ActionCategory(
    title: 'Employee\nBenefits',
    icon: Iconsax.gift5,
    iconColor: Color(0xFFFFC107), // أصفر
  ),
  ActionCategory(
    title: 'Internal\nCommunication',
    icon: Iconsax.message5,
    iconColor: Color(0xFFFF6B35), // برتقالي
  ),
  ActionCategory(
    title: 'Jobs\n& Recruitment',
    icon: Iconsax.people5,
    iconColor: Color(0xFF607D8B), // رمادي
  ),
  ActionCategory(
    title: 'Training\n& Certificates',
    icon: Iconsax.teacher5,
    iconColor: Color(0xFF29B6F6), // أزرق
  ),
  ActionCategory(
    title: 'Latest\nOffers',
    icon: Iconsax.tag5,
    iconColor: Color(0xFFFF6B35), // برتقالي
  ),
];

class HomeActionsGrid extends StatelessWidget {
  const HomeActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final category = _mockCategories[index];
            return ActionCardWidget(category: category);
          },
          childCount: _mockCategories.length, 
        ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
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
              color: Colors.black,
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
