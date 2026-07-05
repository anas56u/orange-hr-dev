import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/login/presentation/pages/login_screen.dart';
import 'package:provider/provider.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // ── Animation setup ────────────────────────────────────────────────
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Fade: 0 → 1 over the first 60% of the timeline.
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    // Scale: 0.6 → 1.0 with a gentle elastic overshoot.
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.elasticOut),
      ),
    );

    // Glow (shadow opacity): fades in during the second half.
    _glowAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    // ── App initialization (runs concurrently with animation) ──────────
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAppInitialization();
    });
  }

  Future<void> _startAppInitialization() async {
    final provider = context.read<SplashProvider>();

    await provider.initializeApp();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: _buildOrangeLogo(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Logo — matches the login screen's visual style
  // ---------------------------------------------------------------------------

  Widget _buildOrangeLogo() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6D00)
                    .withValues(alpha: 0.28 * _glowAnimation.value),
                blurRadius: 36 * _glowAnimation.value,
                spreadRadius: 2 * _glowAnimation.value,
                offset: Offset(0, 12 * _glowAnimation.value),
              ),
            ],
          ),
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.asset(
          'assets/images/logo.png',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
