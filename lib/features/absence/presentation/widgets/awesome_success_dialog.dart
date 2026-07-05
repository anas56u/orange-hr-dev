import 'package:flutter/material.dart';

class AwesomeSuccessDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const AwesomeSuccessDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 36,
              spreadRadius: 4,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------------------------------------------------------------
            // Large success badge with a custom-drawn checkmark
            // ---------------------------------------------------------------
            const _SuccessBadge(size: 130),

            const SizedBox(height: 32),

            // ---------------------------------------------------------------
            // Title
            // ---------------------------------------------------------------
            const Text(
              'Awesome Success!',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 24,
                fontWeight: FontWeight.w800,
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
                color: Color(0xFF616161),
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 36),

            // ---------------------------------------------------------------
            // Confirmation Button
            // ---------------------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A large, professional success badge: a soft double-ring green circle
/// with a checkmark drawn (and animated) via CustomPainter for crisp,
/// perfectly-proportioned strokes at any size — no icon-font artifacts.
class _SuccessBadge extends StatefulWidget {
  final double size;

  const _SuccessBadge({required this.size});

  @override
  State<_SuccessBadge> createState() => _SuccessBadgeState();
}

class _SuccessBadgeState extends State<_SuccessBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _checkProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Circle pops in with a gentle overshoot.
    _scale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.elasticOut),
    );

    // Checkmark draws itself in right after the circle lands.
    _checkProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5CBF60), Color(0xFF3F9C46)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF43A047).withValues(alpha: 0.30),
              blurRadius: 28,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        // Soft white ring for a layered, three-dimensional feel.
        padding: EdgeInsets.all(widget.size * 0.07),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(widget.size * 0.07),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF43A047),
            ),
            child: AnimatedBuilder(
              animation: _checkProgress,
              builder: (context, _) {
                return CustomPaint(
                  painter: _CheckmarkPainter(progress: _checkProgress.value),
                  size: Size.square(widget.size),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws a crisp, well-proportioned checkmark with rounded joints,
/// animated as a stroke that "writes itself" from 0% to 100%.
class _CheckmarkPainter extends CustomPainter {
  final double progress;

  _CheckmarkPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.085;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Checkmark points, proportioned relative to the badge size.
    final p1 = Offset(size.width * 0.28, size.height * 0.53);
    final p2 = Offset(size.width * 0.44, size.height * 0.68);
    final p3 = Offset(size.width * 0.74, size.height * 0.34);

    final path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy);

    final metrics = path.computeMetrics().toList();
    final totalLength =
        metrics.fold<double>(0, (sum, m) => sum + m.length);
    final drawLength = totalLength * progress.clamp(0.0, 1.0);

    double drawn = 0;
    final extractedPath = Path();
    for (final metric in metrics) {
      if (drawn >= drawLength) break;
      final remaining = drawLength - drawn;
      final segmentLength = metric.length;
      final take = remaining >= segmentLength ? segmentLength : remaining;
      extractedPath.addPath(metric.extractPath(0, take), Offset.zero);
      drawn += segmentLength;
    }

    canvas.drawPath(extractedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) =>
      oldDelegate.progress != progress;
}