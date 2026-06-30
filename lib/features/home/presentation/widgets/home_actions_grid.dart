import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../domain/entities/action_category.dart';
import '../pages/category_detail_screen.dart';
import '../pages/placeholder_sub_page.dart';

/// Categories with defined sub-actions in [CategoryLocalDataSource].
/// Used to determine whether to navigate to [CategoryDetailScreen]
/// or [PlaceholderSubPage].
const Set<String> _categoriesWithSubPages = {
  'Payroll & Letters',
  'Attendance & Overtime',
  'Objectives & Appraisal',
  'Employee Benefits',
  'Health Insurance',
};

const List<ActionCategory> _mockCategories = [
  ActionCategory(
    title: 'Approval\nCenter',
    icon: Icons.check_circle,
    iconColor: Colors.green,
  ),
  ActionCategory(
    title: 'Payroll\n& Letters',
    icon: Iconsax.document_text5,
    iconColor: Color(0xFF65B4E3),
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
            return ActionCardWidget(
              category: category,
              onTap: () => _navigateToCategory(context, category),
            );
          },
          childCount: _mockCategories.length,
        ),
      ),
    );
  }

  /// Navigates to the appropriate screen based on whether the category
  /// has defined sub-actions or not.
  void _navigateToCategory(BuildContext context, ActionCategory category) {
    final displayTitle = category.displayTitle;

    if (_categoriesWithSubPages.contains(displayTitle)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryDetailScreen(category: category),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PlaceholderSubPage(title: displayTitle),
        ),
      );
    }
  }
}

class ActionCardWidget extends StatefulWidget {
  final ActionCategory category;

  // Best Practice: تمرير دالة تنفيذية من الأب للابن
  // لكي نحدد ماذا سيحدث برمجياً عند الضغط (مثل فتح صفحة جديدة)
  final VoidCallback? onTap;

  const ActionCardWidget({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  State<ActionCardWidget> createState() => _ActionCardWidgetState();
}

class _ActionCardWidgetState extends State<ActionCardWidget> {
  // متغير يحفظ حالة الكرت: هل هو مضغوط الآن أم لا؟
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // عند بداية لمس الشاشة
      onTapDown: (_) {
        setState(() {
          isPressed = true; // تغيير الحالة إلى "مضغوط"
        });
      },
      // عند رفع الإصبع (اكتمال الضغطة بنجاح)
      onTapUp: (_) {
        setState(() {
          isPressed = false; // إعادة الحالة للوضع الطبيعي
        });

        // تنفيذ الحدث الفعلي إذا تم تمريره (مثل الانتقال لصفحة أخرى)
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      // عند سحب الإصبع بعيداً عن الكرت قبل إفلاته (إلغاء الضغطة)
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },

      // Best Practice: استخدام AnimatedContainer بدلاً من Container العادي
      // هذا سيعطي انتقالاً حركياً ناعماً (Smooth Transition) للألوان بدلاً من التغير المفاجئ
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150), // سرعة التغير
        decoration: BoxDecoration(
          // إذا كان مضغوطاً نجعل الخلفية سوداء، وإلا بيضاء
          color: isPressed ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
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
              color: isPressed ? Colors.white : widget.category.iconColor,
              size: 40.0,
            ),
            const SizedBox(height: 29),
            Text(
              widget.category.title,
              style: TextStyle(
                // إذا كان مضغوطاً نجعل النص أبيض، وإلا أسود
                color: isPressed ? Colors.white : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
