import 'package:flutter/material.dart';

/// A single selectable row in the [AbsenceTypesScreen] list.
///
/// Displays a radio-style circle indicator on the left and the
/// type title on the right, separated by a bottom divider —
/// matching the "Select Type" design exactly.
///
/// The radio indicator is purely visual: an empty circle when
/// [isSelected] is false, and a filled orange dot when true.
class AbsenceTypeListItem extends StatelessWidget {
  /// The display name of this absence type.
  final String title;

  /// Whether this type is currently selected (fills the radio dot).
  final bool isSelected;

  /// Called when the user taps this row.
  final VoidCallback? onTap;

  const AbsenceTypeListItem({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  // --- Const style tokens ----------------------------------------------------

  static const _itemPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16.0,
  );

  static const _bottomBorder = Border(
    bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1.0),
  );

  static const _unselectedBorderColor = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: _itemPadding,
        decoration: const BoxDecoration(border: _bottomBorder),
        child: Row(
          children: [
            // --- Radio circle indicator ---
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.orange : _unselectedBorderColor,
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.orange : Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
