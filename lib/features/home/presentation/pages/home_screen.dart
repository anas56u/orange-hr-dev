import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_carousel_banner.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_actions_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: HomeBottomNavBar(),
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: SafeArea(
        // 1. استخدام CustomScrollView بدلاً من SingleChildScrollView
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // 2. تغليف العناصر العادية (النصوص والبانر) بـ SliverToBoxAdapter
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi Anas", // قمت بتعديل الاسم هنا 😉
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Color(0xFF606060), 
                            fontSize: 18,
                            height: 1.2,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: HomeCarouselBanner(),
                  ),
                ],
              ),
            ),
            
            // 3. استدعاء الـ Grid والذي قمنا بتحويله إلى Sliver
            const HomeActionsGrid(),
            
            // 4. المسافة السفلية كـ Sliver
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}