import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/notifications/domain/models/notification_item.dart';

/// A single row in the notifications list.
///
/// Renders a circular avatar, sender name (bold), action text (grey),
/// and a right-aligned time label. Unread items get a subtle tinted
/// background so the user can distinguish new from old at a glance.
class NotificationListItem extends StatelessWidget {
  final NotificationItem notification;

  const NotificationListItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      color:
           Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        children: [
          // --- Avatar ---
          _AvatarCircle(imageUrl: notification.senderImageUrl),
          const SizedBox(width: 14),

          // --- Name + Action ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.senderName,
                  style: TextStyle(
                    color: appColors.primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notification.actionText,
                  style: TextStyle(
                    color: appColors.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // --- Time Ago ---
          Text(
            notification.timeAgo,
            style: TextStyle(
              color: appColors.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small const-friendly widget for the circular avatar.
class _AvatarCircle extends StatelessWidget {
  final String imageUrl;

  const _AvatarCircle({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 46,
        height: 46,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 46,
          height: 46,
          color: appColors.avatarPlaceholder,
          child: Icon(Icons.person, color: appColors.iconDefault, size: 24),
        ),
      ),
    );
  }
}
