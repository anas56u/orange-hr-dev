/// Data model for a single notification entry.
class NotificationItem {
  final String senderName;
  final String senderImageUrl;
  final String actionText;
  final String timeAgo;

  const NotificationItem({
    required this.senderName,
    required this.senderImageUrl,
    required this.actionText,
    required this.timeAgo,
  });
}

/// Dummy notifications matching the design screenshot.
const List<NotificationItem> mockNotifications = [
  NotificationItem(
    senderName: 'Orange Radio',
    senderImageUrl:
        'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?q=80&w=256',
    actionText: 'Shared a post',
    timeAgo: '2h',
  ),
  NotificationItem(
    senderName: 'Philippe Mansour',
    senderImageUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
    actionText: 'Shared a story',
    timeAgo: '1d',
  ),
  NotificationItem(
    senderName: 'Orange Radio',
    senderImageUrl:
        'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?q=80&w=256',
    actionText: 'Shared a post',
    timeAgo: '1d',
  ),
  NotificationItem(
    senderName: 'Fareez Barakat',
    senderImageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=256',
    actionText: 'Shared a story',
    timeAgo: '1d',
  ),
  NotificationItem(
    senderName: 'Orange Radio',
    senderImageUrl:
        'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?q=80&w=256',
    actionText: 'Shared a post',
    timeAgo: '2d',
  ),
  NotificationItem(
    senderName: 'Orange Radio',
    senderImageUrl:
        'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?q=80&w=256',
    actionText: 'Shared a post',
    timeAgo: '2d',
  ),
  NotificationItem(
    senderName: 'Philippe Mansour',
    senderImageUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
    actionText: 'Shared a story',
    timeAgo: '3d',
  ),
  NotificationItem(
    senderName: 'Sara Haddad',
    senderImageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=256',
    actionText: 'Shared a post',
    timeAgo: '3d',
  ),
  NotificationItem(
    senderName: 'Orange Radio',
    senderImageUrl:
        'https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?q=80&w=256',
    actionText: 'Shared a post',
    timeAgo: '4d',
  ),
  NotificationItem(
    senderName: 'Ahmad Khalil',
    senderImageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=256',
    actionText: 'Shared a story',
    timeAgo: '5d',
  ),
];
