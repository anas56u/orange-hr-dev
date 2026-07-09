import 'package:flutter/material.dart';
import 'category_action_item.dart';

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