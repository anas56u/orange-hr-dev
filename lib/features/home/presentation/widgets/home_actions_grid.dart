import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import '../../domain/entities/action_category.dart';
import '../pages/category_detail_screen.dart';
import '../pages/latest_offers_screen.dart';
import '../../../../features/absence/presentation/pages/absence_management_screen.dart';

const Set<String> _categoriesWithSubPages = {
  'Payroll & Letters',
  'Attendance & Overtime',
  'Objectives & Appraisal',
  'Employee Benefits',
  'Health Insurance',
  'Approval Center',
  'Jobs & Recruitment',
  'Training & Certificates',
  'Internal Communication',
};

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
    title: 'Payroll\n& Letters',
    icon: Iconsax.document_text5,
    iconColor: Color(0xFF65B4E3),
  ),

  ActionCategory(
    title: 'Health\nInsurance',
    icon: Iconsax.heart5,
    iconColor: Color(0xFFF396D1),
  ),
  ActionCategory(
    title: 'Objectives\n& Appraisal',
    icon: Iconsax.award,
    iconColor: Color(0xFF4CAF50),
  ),
  ActionCategory(
    title: 'Employee\nBenefits',
    icon: Iconsax.gift5,
    iconColor: Color(0xFFFFC107),
  ),
  ActionCategory(
    title: 'Internal\nCommunication',
    icon: Iconsax.message5,
    iconColor: Color(0xFFFF6B35),
  ),
  ActionCategory(
    title: 'Jobs\n& Recruitment',
    icon: Iconsax.people5,
    iconColor: Color(0xFF607D8B),
  ),
  ActionCategory(
    title: 'Training\n& Certificates',
    icon: Iconsax.teacher5,
    iconColor: Color(0xFF29B6F6),
  ),
  ActionCategory(
    title: 'Latest\nOffers',
    icon: Iconsax.tag5,
    iconColor: Color(0xFFFF6B35),
  ),
];

class HomeActionsGrid extends StatelessWidget {
  const HomeActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final category = _mockCategories[index];
          return ActionCardWidget(
            category: category,

            onTap: () => _navigateToCategory(context, category),
          );
        }, childCount: _mockCategories.length),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, ActionCategory category) {
    final displayTitle = category.displayTitle;

    if (displayTitle == 'Latest Offers') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const LatestOffersScreen()));
      return;
    }

    if (displayTitle == 'Absence Management') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AbsenceManagementScreen()),
      );
      return;
    }

    if (_categoriesWithSubPages.contains(displayTitle)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryDetailScreen(category: category),
        ),
      );
    } else {}
  }
}

class ActionCardWidget extends StatefulWidget {
  final ActionCategory category;

  final VoidCallback? onTap;

  const ActionCardWidget({super.key, required this.category, this.onTap});

  @override
  State<ActionCardWidget> createState() => _ActionCardWidgetState();
}

class _ActionCardWidgetState extends State<ActionCardWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    context.locale;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });

        if (widget.onTap != null) {
          widget.onTap!();
        }
      },

      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(

          color: isPressed ? appColors.primaryText : appColors.cardBackground,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: appColors.shadowColor,
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
            Icon(
              widget.category.icon,
              color: isPressed ? appColors.cardBackground : widget.category.iconColor,
              size: 40.0,
            ),
            const SizedBox(height: 12),
            Text(
              context.tr(widget.category.title),
              style: TextStyle(

                color: isPressed ? appColors.cardBackground : appColors.primaryText,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}