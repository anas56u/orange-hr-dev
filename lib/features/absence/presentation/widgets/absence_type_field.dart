import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class AbsenceTypeField extends StatelessWidget {

  final String? selectedType;

  final VoidCallback? onTap;

  const AbsenceTypeField({super.key, this.selectedType, this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasValue = selectedType != null && selectedType!.isNotEmpty;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: InputDecorator(
          isEmpty: !hasValue,
          decoration: InputDecoration(
            labelText: 'Absence Type'.tr(),
            labelStyle: TextStyle(
              color: hasValue ? appColors.brandOrange : appColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            floatingLabelStyle: TextStyle(
              color: appColors.brandOrange,
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
                hasValue ? selectedType!.tr() : '',
                style: TextStyle(
                  color: appColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.chevron_right, color: appColors.iconDefault, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}