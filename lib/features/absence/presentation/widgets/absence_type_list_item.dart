import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class AbsenceTypeListItem extends StatelessWidget {

  final String title;

  final bool isSelected;

  final VoidCallback? onTap;

  const AbsenceTypeListItem({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

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
                title.tr(),
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