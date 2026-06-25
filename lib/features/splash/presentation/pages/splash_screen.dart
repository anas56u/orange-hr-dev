import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/home/presentation/pages/home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAppInitialization();
    });
  }

  Future<void> _startAppInitialization() async {
    final provider = context.read<SplashProvider>();

    await provider.initializeApp();

    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen() ) );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 1),
          curve: Curves
              .easeOutBack, 
          builder: (context, scaleValue, child) {
            return Transform.scale(scale: scaleValue, child: child);
          },
          child: _buildOrangeLogo(),
        ),
      ),
    );
  }

  Widget _buildOrangeLogo() {
    return Image.asset("assets/images/logo.jpg",height: 150,width: 150,);
  }
}
