import 'package:flutter/material.dart';

class ContactInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData actionIcon;
  final Color actionIconColor;
  final VoidCallback? onActionTap;

  const ContactInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.actionIcon,
    required this.actionIconColor,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 19.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFFF8C00),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // --- Action Icon ---
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onActionTap,
            child: Icon(actionIcon, color: actionIconColor, size: 30),
          ),
        ],
      ),
    );
  }
}
