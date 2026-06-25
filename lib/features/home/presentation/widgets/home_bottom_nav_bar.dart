import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // سر الأداء العالي: نستخدم Selector لمراقبة متغير الـ currentTabIndex فقط
    // هذا يضمن أن شريط التنقل سيعيد رسم نفسه فقط عند الضغط، دون التأثير على بقية الشاشة
    return Selector<HomeProvider, int>(
      selector: (context, provider) => provider.currentTabIndex,
      builder: (context, currentTabIndex, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // إضافة ظل خفيف جداً ونظيف من الأعلى لفصل الـ NavBar عن محتوى الشاشة احترافياً
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentTabIndex,
            onTap: (index) {
              // استدعاء دالة التحديث باستخدام context.read لضمان الكفاءة والأداء
              context.read<HomeProvider>().updateTabIndex(index);
            },
            
            // خصائص التصميم المطابقة للهوية والنظافة البصرية
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed, // يضمن ثبات الأيقونات وتوزيعها العادل
            selectedItemColor: Colors.orange, // لون الهوية النشط
            unselectedItemColor: Colors.grey[400], // لون العناصر غير النشطة
            showSelectedLabels: false, // إخفاء النصوص ليبقى المظهر مبسطاً كما في التصميم
            showUnselectedLabels: false,
            elevation: 0, // إلغاء الـ elevation الافتراضي لأننا أضفنا ظلاً مخصصاً ناعماً
            
            // العناصر الأربعة المطلوبة في التصميم
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, size: 26),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined, size: 26),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_outlined, size: 26),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined, size: 26),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}