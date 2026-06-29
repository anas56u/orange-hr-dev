import 'package:flutter/material.dart';

/// A full-width outlined "BACK" button matching the design.
class BackActionButton extends StatelessWidget {
  const BackActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black, width: 3.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          foregroundColor: Colors.black87,
        ),
        child: const Text(
          'BACK',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
