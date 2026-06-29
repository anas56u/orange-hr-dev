import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orange_hr_dev/features/home/presentation/providers/home_provider.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_tab_content.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_directory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavBar(),
      backgroundColor: Colors.white,
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: Selector<HomeProvider, int>(
          selector: (context, provider) => provider.currentTabIndex,
          builder: (context, currentIndex, child) {
            return IndexedStack(
              index: currentIndex,
              children: const [
                HomeTabContent(), // Index 0: Home
                EmployeeDirectoryScreen(), // Index 1: Address Book
                Center(child: Text("Folder Content")), // Index 2: Placeholder
                Center(child: Text("Notifications")), // Index 3: Placeholder
                Center(child: Text("Settings")), // Index 4: Placeholder
              ],
            );
          },
        ),
      ),
    );
  }
}