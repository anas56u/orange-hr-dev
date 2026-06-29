import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/inbox/domain/models/worklist_item.dart';
import 'package:orange_hr_dev/features/inbox/presentation/widgets/worklist_item_icon.dart';

class WorklistListItem extends StatelessWidget {
  final WorklistItem item;

  const WorklistListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isPersonItem = item.senderName != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Leading: icon or avatar ---
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
                    style: const TextStyle(
                      color: Colors.black87,
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
              style: const TextStyle(
                color: Color(0xFF9E9E9E),
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
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 42,
        height: 42,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 42,
          height: 42,
          color: Colors.grey[300],
          child: const Icon(Icons.person, color: Colors.grey, size: 22),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          message,
          style: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
