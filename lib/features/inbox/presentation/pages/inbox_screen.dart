import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/inbox/domain/models/worklist_item.dart';
import 'package:orange_hr_dev/features/inbox/presentation/widgets/worklist_list_item.dart';

/// Inbox / Worklist tab displayed inside the home IndexedStack.
///
/// Uses [ListView.separated] for lazy rendering — only visible items
/// are built, enabling smooth 60fps scrolling even with many items.
class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Title ---
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            'Worklist',
            style: TextStyle(
              color: appColors.primaryText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // --- Worklist items ---
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: mockWorklist.length,
            separatorBuilder: (context, index) => Divider(
              color: appColors.dividerColor,
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              return WorklistListItem(item: mockWorklist[index]);
            },
          ),
        ),
      ],
    );
  }
}
