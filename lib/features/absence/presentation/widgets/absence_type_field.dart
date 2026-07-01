import 'package:flutter/material.dart';

/// A tappable outlined field that displays the selected absence type
/// or a placeholder hint when no type has been chosen yet.
///
/// Matches the design: rounded border, hint/value text on the left,
/// chevron-right icon on the right. The parent controls behavior
/// via [onTap] (typically navigating to [AbsenceTypesScreen]).
///
/// This widget is fully stateless — the display value comes from
/// [selectedType] and state is managed by [AbsenceProvider].
class AbsenceTypeField extends StatelessWidget {
  /// The currently selected type name, or `null` for the hint state.
  final String? selectedType;

  /// Called when the user taps the field.
  final VoidCallback? onTap;

  const AbsenceTypeField({super.key, this.selectedType, this.onTap});

  // --- Const style tokens ----------------------------------------------------

  static const _hintStyle = TextStyle(
    color: Colors.black54,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const _valueStyle = TextStyle(
    color: Colors.black87,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static const _fieldPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 12.0,
  );

  static const _contentPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 16.0,
  );

  static const _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    final hasValue = selectedType != null && selectedType!.isNotEmpty;

    return Padding(
      padding: _fieldPadding,
      child: InkWell(
        borderRadius: BorderRadius.circular(_borderRadius),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: _contentPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasValue ? selectedType! : 'Absence Type',
                  style: hasValue ? _valueStyle : _hintStyle,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.black54,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
