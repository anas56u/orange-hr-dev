import 'package:flutter/material.dart';
import '../widgets/absence_type_list_item.dart';

/// Screen that displays a selectable list of absence types.
///
/// Receives the [currentSelection] (if any) so the matching
/// radio indicator appears filled. When the user taps a type,
/// [Navigator.pop] returns the selected type string back to
/// [AbsenceManagementScreen] via the reverse-navigation pattern.
///
/// Uses [ListView.builder] for efficient widget recycling,
/// even though the current mock list is small — this ensures
/// the pattern scales if the list grows from an API response.
class AbsenceTypesScreen extends StatelessWidget {
  /// The type that is already selected on the form, if any.
  /// Used to pre-fill the radio indicator for the matching row.
  final String? currentSelection;

  const AbsenceTypesScreen({super.key, this.currentSelection});

  /// Mock absence types matching the design (Type #1 – #4).
  static const List<String> _absenceTypes = [
    'Type #1',
    'Type #2',
    'Type #3',
    'Type #4',
  ];

  static const _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header: back button + title ---
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 4),
                  const Text('Select Type', style: _titleStyle),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // --- Types list (recycled via ListView.builder) ---
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _absenceTypes.length,
                itemBuilder: (context, index) {
                  final type = _absenceTypes[index];
                  return AbsenceTypeListItem(
                    title: type,
                    isSelected: type == currentSelection,
                    onTap: () => Navigator.of(context).pop(type),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
