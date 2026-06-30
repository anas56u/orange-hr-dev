import 'package:flutter/material.dart';

/// Immutable domain entity representing a category card on the home grid.
///
/// Holds the display metadata (title, icon, color) used consistently
/// across the home grid AND the category detail screen header.
class ActionCategory {
  final String title;
  final IconData icon;
  final Color iconColor;

  const ActionCategory({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  /// Returns the title with line-break characters replaced by spaces,
  /// suitable for single-line display (e.g. detail screen headers).
  String get displayTitle => title.replaceAll('\n', ' ');
}
