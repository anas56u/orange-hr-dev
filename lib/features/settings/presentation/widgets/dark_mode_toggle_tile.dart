import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DarkModeToggleTile extends StatefulWidget {
  const DarkModeToggleTile({super.key});

  @override
  State<DarkModeToggleTile> createState() => _DarkModeToggleTileState();
}

class _DarkModeToggleTileState extends State<DarkModeToggleTile> {
  // Strictly UI only local state per requirements
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    context.locale; // Subscribe to locale changes
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('dark_mode'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.tr('dark_mode_desc'),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isDarkMode,
            activeTrackColor: const Color(0xFFFF6D00),
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
