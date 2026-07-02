import 'package:flutter/material.dart';
import 'absence_type_list_item.dart';

/// A modal bottom sheet that displays a selectable list of absence types.
///
/// Uses [ListView.builder] for optimal widget recycling. When the user
/// taps a type, [Navigator.pop] returns the selected [String] to the
/// caller (typically awaited by `showModalBottomSheet<String>`).
///
/// The [currentSelection] parameter highlights the already-chosen type
/// with a filled radio indicator via [AbsenceTypeListItem.isSelected].
class AbsenceTypeBottomSheet extends StatelessWidget {
  /// The type that is already selected on the form, if any.
  final String? currentSelection;

  const AbsenceTypeBottomSheet({super.key, this.currentSelection});

  /// Mock absence types matching the design (Type #1 – #4).
  static const List<String> _absenceTypes = [
    'Type #1',
    'Type #2',
    'Type #3',
    'Type #4',
  ];

  // --- Const style tokens ----------------------------------------------------

  static const _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const _handleWidth = 40.0;
  static const _handleHeight = 4.0;
  static const _handleColor = Color(0xFFBDBDBD);
  static const _sheetRadius = BorderRadius.vertical(top: Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: _sheetRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Drag handle ---
          const Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
            child: Center(
              child: SizedBox(
                width: _handleWidth,
                height: _handleHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _handleColor,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ),
          ),

          // --- Header ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Type', style: _titleStyle),
            ),
          ),

          const SizedBox(height: 4),

          // --- Types list (recycled via ListView.builder) ---
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
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

          // Bottom safe-area spacing
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}
