import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/inbox/domain/models/worklist_item.dart';

class WorklistItemIcon extends StatelessWidget {
  final WorklistItemType type;

  const WorklistItemIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final (IconData icon, Color bg, Color fg) = switch (type) {
      WorklistItemType.leaveApproval => (
          Icons.access_time,
          const Color(0xFFE3F2FD),
          const Color(0xFF1E88E5),
        ),
      WorklistItemType.cardRequest => (
          Icons.favorite,
          const Color(0xFFFCE4EC),
          const Color(0xFFEC407A),
        ),
      WorklistItemType.objectiveApproved => (
          Icons.check_circle_outline,
          const Color(0xFFE8F5E9),
          const Color(0xFF43A047),
        ),
      WorklistItemType.leaveRequest => (
          Icons.person,
          const Color(0xFFF5F5F5),
          const Color(0xFF757575),
        ),
    };

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: fg, size: 22),
    );
  }
}