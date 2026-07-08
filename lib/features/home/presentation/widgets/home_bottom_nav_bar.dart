import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import '../providers/home_provider.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale; // Subscribe to locale changes
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: appColors.shadowColor,
            blurRadius: 20,
            offset: const Offset(
              0,
              -5,
            ),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomNavItem(
              icon: Iconsax.home,
              activeIcon: Iconsax.home_15,
              index: 0,
              onTap: () => context.read<HomeProvider>().updateTabIndex(0),
            ),
            CustomNavItem(
              icon: Icons.book,
              activeIcon: Icons.book,
              index: 1,
              onTap: () => context.read<HomeProvider>().updateTabIndex(1),
            ),
            CustomNavItem(
              icon: Iconsax.direct_inbox,
              activeIcon: Iconsax.direct_inbox5,
              index: 2,
              onTap: () => context.read<HomeProvider>().updateTabIndex(2),
            ),
            CustomNavItem(
              icon: Iconsax.notification,
              activeIcon: Iconsax.notification5,
              index: 3,
              onTap: () => context.read<HomeProvider>().updateTabIndex(3),
            ),
            CustomNavItem(
              icon: Iconsax.setting_2,
              activeIcon: Iconsax.setting_2,
              index: 4,
              onTap: () => context.read<HomeProvider>().updateTabIndex(4),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final int index;
  final VoidCallback onTap;

  const CustomNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // 3. هنا يكمن سر الأداء العالي: استخدمنا Selector يعيد قيمة bool فقط
      child: Selector<HomeProvider, bool>(
        selector: (context, provider) => provider.currentTabIndex == index,
        builder: (context, isSelected, child) {
          // الكود هنا بداخل الـ builder لن يُنفذ إلا إذا تغيرت قيمة isSelected فقط!
          final appColors = Theme.of(context).extension<AppColorsExtension>()!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? appColors.primaryText : appColors.secondaryText,
                size: 26,
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                height: 4,
                width: isSelected ? 16 : 0,
                decoration: BoxDecoration(
                  color: isSelected ? appColors.brandOrange : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
