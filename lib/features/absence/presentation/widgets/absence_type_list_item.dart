import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

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

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: _itemPadding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: appColors.dividerColor, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            // --- Radio circle indicator ---
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? appColors.brandOrange : appColors.inputBorderColor,
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColors.brandOrange,
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
                  color: isSelected ? appColors.brandOrange : appColors.primaryText,
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
