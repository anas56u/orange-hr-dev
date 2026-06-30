import 'package:flutter/material.dart';
import 'category_action_item.dart';

/// Immutable domain entity representing a category with its full detail:
/// display metadata (icon, color, title) and the list of child actions.
class CategoryDetail {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<CategoryActionItem> actions;

  const CategoryDetail({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.actions,
  });
}
