import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart'; // استدعاء مكتبة الأيقونات
import '../providers/home_provider.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم watch لمراقبة التغيرات في الـ index وإعادة بناء الشريط السفلي فقط
    final currentIndex = context.watch<HomeProvider>().currentTabIndex;

    return Container(
      // Margin: لعمل مسافة خارجية تجعل الشريط "عائماً" (Floating)
      // Padding: لعمل مسافة داخلية تمنع الأيقونات من الالتصاق بحواف الحاوية
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ), // حواف دائرية علوية فقط تتطابق مع التصميم
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.8,
            ), // ظل خفيف جداً يضيف عمقاً للتصميم
            blurRadius: 20,
            offset: const Offset(0, 10), // إزاحة الظل للأسفل لتعزيز تأثير الطفو
          ),
        ],
      ),
      child: SafeArea(
        bottom:
            false, // لا نحتاج الـ SafeArea من الأسفل لأننا استخدمنا Margin يبعدنا عن حافة الشاشة
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // توزيع الأيقونات بمسافات متساوية تماماً
          children: [
            CustomNavItem(
              icon: Iconsax.home,
              activeIcon: Iconsax.home_15, // النسخة الممتلئة
              index: 0,
              currentIndex: currentIndex,
              onTap: () => context.read<HomeProvider>().updateTabIndex(0),
            ),
            CustomNavItem(
              icon: Icons.book,
              activeIcon:Icons.book,
              index: 1,
              currentIndex: currentIndex,
              onTap: () => context.read<HomeProvider>().updateTabIndex(1),
            ),
            CustomNavItem(
              icon: Iconsax
                  .direct_inbox, // أيقونة المنتصف (المربع الذي بداخله زائد)
              activeIcon: Iconsax.direct_inbox5,
              index: 2,
              currentIndex: currentIndex,
              onTap: () => context.read<HomeProvider>().updateTabIndex(2),
            ),
            CustomNavItem(
              icon: Iconsax.notification,
              activeIcon: Iconsax.notification5,
              index: 3,
              currentIndex: currentIndex,
              onTap: () => context.read<HomeProvider>().updateTabIndex(3),
            ),
            CustomNavItem(
              icon: Iconsax.setting_2,
              activeIcon: Iconsax.setting_25,
              index: 4,
              currentIndex: currentIndex,
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
  final int currentIndex;
  final VoidCallback onTap;

  const CustomNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      // Best Practice: Opaque يضمن استجابة اللمس حتى لو ضغط المستخدم على الفراغ حول الأيقونة
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // مهم جداً لمنع الـ Column من التمدد عمودياً بشكل لا نهائي
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected
                ? Colors.black
                : Colors
                      .grey
                      .shade400, // لون رمادي فاتح عند عدم التفعيل ليتطابق مع الصورة
            size: 26,
          ),
          const SizedBox(height: 6), // مسافة بين الأيقونة والمؤشر البرتقالي
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic, // حركة انسيابية ناعمة جداً
            height: 4,
            width: isSelected
                ? 16
                : 0, // يختفي المؤشر إذا لم تكن الأيقونة محددة
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
