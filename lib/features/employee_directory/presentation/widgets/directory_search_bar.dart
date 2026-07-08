import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class DirectorySearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const DirectorySearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: appColors.primaryText, fontSize: 15),
        decoration: InputDecoration(
          hintText: "Search by name, position, unit...",
          hintStyle: TextStyle(
            color: appColors.secondaryText,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: appColors.secondaryText,
            size: 22,
          ),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: appColors.iconDefault,
                    size: 20,
                  ),
                  onPressed: onClear,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          filled: true,
          fillColor: appColors.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: appColors.inputBorderColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: appColors.inputBorderColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: appColors.brandOrange, width: 1.5),
          ),
        ),
      ),
    );
  }
}
