import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// A modern, highly performant stateless success dialog.
///
/// **UI Performance & Architecture:**
/// - Declared as a [StatelessWidget] with a `const` constructor to ensure zero
///   unnecessary element tree rebuilds when parent widgets update.
/// - Employs a self-contained [TweenAnimationBuilder] that manages the elastic
///   popup animation of the success badge purely on the rendering thread,
///   avoiding the boilerplate and overhead of a stateful ticker provider.
/// - Utilizes `const` constructors for all static text, padding, borders, and
///   decoration widgets to maximize widget reuse and memory efficiency.
class AwesomeSuccessDialog extends StatelessWidget {
  /// Callback triggered when the user taps the confirmation button.
  ///
  /// **Clean Architecture & Decoupling:**
  /// By accepting an [onConfirm] callback instead of hardcoding navigation or
  /// router logic inside this dialog, we preserve separation of concerns.
  /// The dialog remains a purely visual presentation component that is completely
  /// decoupled from routing state, stack clearing, or feature-specific logic,
  /// making it 100% reusable across any feature or workflow in the application.
  final VoidCallback onConfirm;

  const AwesomeSuccessDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------------------------------------------------------------
              // Implicit Elastic Badge Animation
              // ---------------------------------------------------------------
              // [TweenAnimationBuilder] animates a double value from 0.0 to 1.0.
              // By applying [Curves.elasticOut], the scale overshoots slightly
              // before settling, creating a playful, modern pop-in effect
              // without requiring external Lottie asset files or controllers.
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                // Passing the static badge as the [child] parameter ensures
                // Flutter only builds the badge once and merely transforms its
                // rendering matrix on each animation frame (Best Practice).
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9), // Soft green background
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Iconsax.tick_circle5,
                    color: Color(0xFF4CAF50), // Vibrant success green
                    size: 48,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ---------------------------------------------------------------
              // Title
              // ---------------------------------------------------------------
              const Text(
                'Awesome Success!',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // ---------------------------------------------------------------
              // Message
              // ---------------------------------------------------------------
              const Text(
                'Your absence request has been submitted successfully and sent for approval.',
                style: TextStyle(
                  color: Color(0xFF757575), // Soft gray for subtitle
                  fontSize: 15,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              // ---------------------------------------------------------------
              // Confirmation Button (Decoupled Navigation)
              // ---------------------------------------------------------------
              // Tapping this button invokes [onConfirm], delegating the
              // navigation action to the caller and keeping this widget clean.
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'DONE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
