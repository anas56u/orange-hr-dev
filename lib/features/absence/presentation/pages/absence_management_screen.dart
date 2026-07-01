import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/absence_provider.dart';
import '../widgets/absence_type_field.dart';
import 'absence_types_screen.dart';

/// Main screen for the Absence Management feature.
///
/// Displays the "Submit Absence" form with a tappable "Absence Type"
/// field. Tapping the field navigates to [AbsenceTypesScreen]; the
/// selected value is returned via [Navigator.pop] and stored in
/// [AbsenceProvider].
///
/// Uses a scoped [ChangeNotifierProvider] that auto-disposes when
/// this screen is popped — same lifecycle pattern as
/// [CategoryDetailScreen].
class AbsenceManagementScreen extends StatelessWidget {
  const AbsenceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AbsenceProvider>(
      create: (_) => AbsenceProvider(),
      child: const _AbsenceManagementBody(),
    );
  }
}

/// The actual scaffold body — separated so [Consumer] can access
/// the [AbsenceProvider] from the ancestor [ChangeNotifierProvider].
class _AbsenceManagementBody extends StatelessWidget {
  const _AbsenceManagementBody();

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
                  const Text('Submit Absence', style: _titleStyle),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- Absence Type field ---
            // Rebuilds only when the selected type changes,
            // thanks to the scoped [Consumer].
            Consumer<AbsenceProvider>(
              builder: (context, provider, _) {
                return AbsenceTypeField(
                  selectedType: provider.selectedType,
                  onTap: () async {
                    // Navigate to the types selection screen and
                    // await the returned value (reverse navigation).
                    final result = await Navigator.of(context).push<String>(
                      MaterialPageRoute(
                        builder: (_) => AbsenceTypesScreen(
                          currentSelection: provider.selectedType,
                        ),
                      ),
                    );

                    // Update the provider only if a type was selected
                    // and the widget is still mounted.
                    if (result != null && context.mounted) {
                      context.read<AbsenceProvider>().setSelectedType(result);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
