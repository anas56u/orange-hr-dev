import 'package:flutter/material.dart';

/// A tappable outlined field that displays the selected absence type
/// or a placeholder hint when no type has been chosen yet.
///
/// Matches the design: rounded orange/grey border, floating label on top,
/// and chevron-right icon on the right.
class AbsenceTypeField extends StatelessWidget {
  /// The currently selected type name, or `null` for the hint state.
  final String? selectedType;

  /// Called when the user taps the field.
  final VoidCallback? onTap;

  const AbsenceTypeField({super.key, this.selectedType, this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasValue = selectedType != null && selectedType!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: InputDecorator(
          isEmpty: !hasValue,
          decoration: InputDecoration(
            labelText: 'Absence Type',
            labelStyle: TextStyle(
              color: hasValue ? Colors.orange : Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.orange,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: const Color(0xFFE0E0E0),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: const Color(0xFFE0E0E0),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hasValue ? selectedType! : '',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black87, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
