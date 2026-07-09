import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/features/home/presentation/providers/home_provider.dart';
import 'package:orange_hr_dev/features/notifications/domain/models/notification_item.dart';
import 'package:orange_hr_dev/features/notifications/presentation/widgets/notification_list_item.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: appColors.primaryText),
            onPressed: () {

              context.read<HomeProvider>().updateTabIndex(0);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            'Notifications'.tr(),
            style: TextStyle(
              color: appColors.primaryText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 8),

        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: mockNotifications.length,
            separatorBuilder: (context, index) => Divider(
              color: appColors.dividerColor,
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