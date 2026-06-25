import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // إلغاء الظل تماماً ليتناسب مع التصميم البسيط والنظيف
      scrolledUnderElevation: 0, // يضمن ثبات اللون الأبيض حتى عند التمرير
      
      // 1. اللوغو البرتقالي على اليسار (Leading)
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0), // مسافة أمان من حافة الشاشة اليسرى
        child: _buildOrangeLogo(),
      ),
      leadingWidth: 56, // إعطاء مساحة عرض مناسبة للوغو لمنع انضغاطه
      
      // 2. الصورة الشخصية للموظف على اليمين (Actions)
      actions: [
        _buildProfileAvatar(),
        const SizedBox(width: 16), // مسافة أمان قبل حافة الشاشة اليمنى
      ],
    );
  }

  // ويدجت اللوغو البرتقالي المبسط
  Widget _buildOrangeLogo() {
    return Center(
      child: Image.asset("assets/images/logo.jpg",height: 170,width: 170,)
    );
  }

  // ويدجت الصورة الشخصية (Profile Avatar)
  Widget _buildProfileAvatar() {
    return GestureDetector(
     
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200], 
          border: Border.all(
            color: Colors.grey[300]!, 
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=256', // رابط صورة تجريبية عالية الجودة
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.person, color: Colors.grey);
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}