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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi Mohammed",
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
              HomeActionsGrid(),
              SizedBox(height: 24), // Extra bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
