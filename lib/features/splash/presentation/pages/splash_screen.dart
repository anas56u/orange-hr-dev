import 'package:flutter/material.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.elasticOut),
      ),
    );

    _glowAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    );

    _controller.forward();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

  Widget _buildOrangeLogo() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
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
                color: appColors.brandOrange
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