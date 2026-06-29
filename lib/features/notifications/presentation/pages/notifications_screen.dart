import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/notifications/domain/models/notification_item.dart';
import 'package:orange_hr_dev/features/notifications/presentation/widgets/notification_list_item.dart';

/// Full notifications tab displayed inside the home IndexedStack.
///
/// Uses [ListView.builder] for lazy rendering — only visible items are built.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Title ---
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // --- Notification List ---
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: mockNotifications.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xFFEEEEEE),
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              return NotificationListItem(
                notification: mockNotifications[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
