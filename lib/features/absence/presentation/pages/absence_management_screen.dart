import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/features/home/presentation/pages/home_screen.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import '../providers/absence_provider.dart';
import '../widgets/absence_type_field.dart';
import '../widgets/absence_type_bottom_sheet.dart';
import '../widgets/awesome_success_dialog.dart';

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
                    'Submit Absence'.tr(),
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

                      AbsenceTypeField(
                        selectedType: provider.selectedType,
                        onTap: () => _showTypeBottomSheet(context, provider),
                      ),

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

                      if (provider.calculatedDuration != null)
                        _DurationCard(
                          durationText: provider.calculatedDuration!,
                        ),
                    ],
                  );
                },
              ),
            ),

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

    await provider.submitAbsence();

    if (!context.mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Success Dialog',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, anim1, anim2) {
        return AwesomeSuccessDialog(
          onConfirm: () {

            Navigator.of(context).pop();

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        );
      },

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
                text: label.tr(),
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
              : Text(
                  'SUBMIT'.tr(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}

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