import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/inbox/domain/models/worklist_item.dart';
import 'package:orange_hr_dev/features/inbox/presentation/widgets/worklist_item_icon.dart';

class WorklistListItem extends StatelessWidget {
  final WorklistItem item;

  const WorklistListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isPersonItem = item.senderName != null;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (isPersonItem)
            _SenderAvatar(imageUrl: item.senderImageUrl!)
          else
            WorklistItemIcon(type: item.type),

          const SizedBox(width: 14),

          Expanded(
            child: isPersonItem
                ? _PersonMessageBody(
                    senderName: item.senderName!,
                    message: item.message,
                  )
                : Text(
                    item.message,
                    style: TextStyle(
                      color: appColors.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
          ),

          const SizedBox(width: 12),

          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              item.timeAgo,
              style: TextStyle(
                color: appColors.secondaryText,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SenderAvatar extends StatelessWidget {
  final String imageUrl;

  const _SenderAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 42,
        height: 42,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 42,
          height: 42,
          color: appColors.avatarPlaceholder,
          child: Icon(Icons.person, color: appColors.iconDefault, size: 22),
        ),
      ),
    );
  }
}

class _PersonMessageBody extends StatelessWidget {
  final String senderName;
  final String message;

  const _PersonMessageBody({required this.senderName, required this.message});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: TextStyle(
            color: appColors.primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          message,
          style: TextStyle(
            color: appColors.secondaryText,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}