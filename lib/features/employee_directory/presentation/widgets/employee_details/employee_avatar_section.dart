import 'package:flutter/material.dart';

/// Displays the employee's circular avatar with an orange border,
/// name in orange, and position underneath.
class EmployeeAvatarSection extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String position;

  const EmployeeAvatarSection({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 48, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFFFF8C00),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          position,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
