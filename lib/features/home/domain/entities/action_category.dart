import 'package:flutter/material.dart';

class ActionCategory {
  final String title;
  final IconData icon;
  final Color iconColor;

  const ActionCategory({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  String get displayTitle => title.replaceAll('\n', ' ');
}