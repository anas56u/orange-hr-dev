import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_carousel_banner.dart';

class HomeScreen extends StatelessWidget {
  // إضافة const هنا تضمن كفاءة استهلاك الذاكرة وعدم إعادة بناء هيكل الشاشة دون داعٍ
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // الـ AppBar المبسط (اللوغو + الصورة الشخصية)
      appBar: HomeAppBar(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "Hi Anas",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.15, // تقريب السطرين لبعضهما مثل التصميم تماماً
                        letterSpacing: 0.5,
                      ),
                    ), Text(
                 "welcome back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  
                    height: 1.15, // تقريب السطرين لبعضهما مثل التصميم تماماً
                    letterSpacing: 0.5,
                  ),
                ),
                  ],
                ),
              ),
              
              // 2. الجزء الثاني: بنر الصورة (مدمج مباشرة أسفل العنوان بمسافات متناسقة)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: HomeCarouselBanner(),
              ),
              
              // أي عناصر أو أقسام جديدة سنضيفها هنا بكل سهولة مستقبلاً...
            ],
          ),
        ),
      ),
    );
  }
}

