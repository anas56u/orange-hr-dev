import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orange_hr_dev/features/home/presentation/pages/home_screen.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import '../providers/absence_provider.dart';
import '../widgets/absence_type_field.dart';
import '../widgets/absence_type_bottom_sheet.dart';
import '../widgets/awesome_success_dialog.dart';

/// Main screen for the Absence Management feature.
/// Displays the "Submit Absence" form matching the design:
///   - A tappable **Absence Type** field that opens a [showModalBottomSheet]
///     containing [AbsenceTypeBottomSheet].
///   - **Date** field that opens [showDatePicker].
///   - **From Time** and **To Time** fields that open [showTimePicker].
///   - A **SUBMIT** button enabled only when every field is filled
///     (controlled by [AbsenceProvider.canSubmit]).
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

class _AbsenceManagementBody extends StatelessWidget {
  const _AbsenceManagementBody();

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    icon: Icon(Icons.arrow_back, color: appColors.primaryText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Submit Absence',
                    style: TextStyle(
                      color: appColors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- Form fields ---
            Expanded(
              child: Consumer<AbsenceProvider>(
                builder: (context, provider, _) {
                  final formattedDate = provider.date != null
                      ? '${provider.date!.day} ${_months[provider.date!.month - 1]}, ${provider.date!.year}'
                      : null;

                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      // ── Absence Type field ──
                      AbsenceTypeField(
                        selectedType: provider.selectedType,
                        onTap: () => _showTypeBottomSheet(context, provider),
                      ),

                      // ── Date field ──
                      _FormActionField(
                        label: 'Date',
                        value: formattedDate,
                        icon: Icons.calendar_today_outlined,
                        onTap: () => _pickDate(
                          context: context,
                          current: provider.date,
                          onPicked: provider.setDate,
                        ),
                      ),

                      // ── From Time field ──
                      _FormActionField(
                        label: 'From Time',
                        value: provider.fromTime?.format(context),
                        icon: Icons.access_time,
                        onTap: () => _pickTime(
                          context: context,
                          current: provider.fromTime,
                          onPicked: provider.setFromTime,
                        ),
                      ),

                      // ── To Time field ──
                      _FormActionField(
                        label: 'To Time',
                        value: provider.toTime?.format(context),
                        icon: Icons.access_time,
                        onTap: () => _pickTime(
                          context: context,
                          current: provider.toTime,
                          onPicked: provider.setToTime,
                        ),
                      ),

                      // ── Calculated Duration Box ──
                      if (provider.calculatedDuration != null)
                        _DurationCard(
                          durationText: provider.calculatedDuration!,
                        ),
                    ],
                  );
                },
              ),
            ),

            // --- Submit button ---
            Consumer<AbsenceProvider>(
              builder: (context, provider, _) {
                return _SubmitButton(
                  enabled: provider.canSubmit,
                  isSubmitting: provider.isSubmitting,
                  onPressed: () => _handleSubmit(context, provider),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _showTypeBottomSheet(
    BuildContext context,
    AbsenceProvider provider,
  ) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          AbsenceTypeBottomSheet(currentSelection: provider.selectedType),
    );

    if (result != null && context.mounted) {
      context.read<AbsenceProvider>().setSelectedType(result);
    }
  }

  Future<void> _pickDate({
    required BuildContext context,
    required DateTime? current,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1976D2),
              primary: const Color.fromARGB(255, 224, 117, 17),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  Future<void> _pickTime({
    required BuildContext context,
    required TimeOfDay? current,
    required ValueChanged<TimeOfDay> onPicked,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1976D2),
              primary: const Color.fromARGB(255, 224, 117, 17),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  Future<void> _handleSubmit(
    BuildContext context,
    AbsenceProvider provider,
  ) async {
    // 1. Trigger submission method in the provider and wait for it to complete.
    await provider.submitAbsence();

    // Guard against using context across async gaps if the widget was unmounted.
    if (!context.mounted) return;

    // 2. Display the high-performance AwesomeSuccessDialog using showGeneralDialog.
    // Why showGeneralDialog? It allows us to customize the enter/exit transition
    // duration and animation curves without needing boilerplate animation controllers.
    //
    // Clean Architecture & Decoupling:
    // We pass the navigation callback directly into [onConfirm]. The dialog itself
    // has no knowledge of [HomeScreen] or route stacks; it simply invokes this
    // callback when the user clicks DONE.
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      barrierLabel: 'Success Dialog',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, anim1, anim2) {
        return AwesomeSuccessDialog(
          onConfirm: () {
            // Automatically close the dialog first.
            Navigator.of(context).pop();

            // Navigate to HomeScreen and clear the entire navigation stack so the
            // user cannot press back and return to the absence submission form.
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        );
      },
      // transitionBuilder coordinates how the dialog modal enters and exits the screen.
      // We combine a CurvedAnimation with Curves.easeOutBack for a slight overshoot scale
      // on entry, paired with a FadeTransition for smooth opacity fading.
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: CurvedAnimation(
            parent: anim1,
            curve: Curves.easeOutBack,
          ).value,
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }
}

// =============================================================================
// Private reusable widgets
// =============================================================================

/// A reusable form field with a floating label and red asterisk,
/// matching the exact layout of the screenshot.
class _FormActionField extends StatelessWidget {
  final String label;
  final String? value;
  final IconData icon;
  final VoidCallback? onTap;

  const _FormActionField({
    required this.label,
    required this.icon,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: InputDecorator(
          isEmpty: !hasValue,
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  color: hasValue ? appColors.brandOrange : appColors.primaryText,
                  fontSize: hasValue ? 14 : 16,
                  fontWeight: FontWeight.w500,
                ),
                children: const [
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: appColors.inputBorderColor,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: appColors.inputBorderColor,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hasValue ? value! : '',
                style: TextStyle(
                  color: appColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: appColors.iconDefault, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

/// The submit button pinned to the bottom of the form.
/// Visually disabled (greyed out with white text) when [enabled] is false.
/// Displays a loading spinner when [isSubmitting] is true.
class _SubmitButton extends StatelessWidget {
  final bool enabled;
  final bool isSubmitting;
  final VoidCallback? onPressed;

  const _SubmitButton({
    required this.enabled,
    this.isSubmitting = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: appColors.brandOrange,
            disabledBackgroundColor: appColors.inputBorderColor,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: isSubmitting
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}

/// Pinned container that displays the calculated absence duration
/// (e.g. `01:45 HRS`) when both From Time and To Time are selected.
class _DurationCard extends StatelessWidget {
  final String durationText;

  const _DurationCard({required this.durationText});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: appColors.dividerColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            durationText,
            style: TextStyle(
              color: appColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
