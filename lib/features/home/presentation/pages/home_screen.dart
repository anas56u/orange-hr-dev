import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orange_hr_dev/features/home/presentation/providers/home_provider.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:orange_hr_dev/features/home/presentation/widgets/home_tab_content.dart';
import 'package:orange_hr_dev/features/employee_directory/presentation/pages/employee_directory_screen.dart';
import 'package:orange_hr_dev/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:orange_hr_dev/features/inbox/presentation/pages/inbox_screen.dart';
import 'package:orange_hr_dev/features/settings/presentation/pages/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, int>(
      selector: (context, provider) => provider.currentTabIndex,
      builder: (context, currentIndex, child) {
        return Scaffold(
          bottomNavigationBar: const HomeBottomNavBar(),
          backgroundColor: Colors.white,
          // Hide the shared AppBar on Notifications (index 3) and Settings (index 4)
          appBar: (currentIndex == 3 || currentIndex == 4) ? null : const HomeAppBar(),
          body: SafeArea(
            child: IndexedStack(
              index: currentIndex,
              children: const [
                HomeTabContent(), // Index 0: Home
                EmployeeDirectoryScreen(), // Index 1: Address Book
                InboxScreen(), // Index 2: Inbox / Worklist
                NotificationsScreen(), // Index 3: Notifications
                SettingsScreen(), // Index 4: Settings
              ],
            ),
          ),
        );
      },
    );
  }
}