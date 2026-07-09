import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

import '../../../home/presentation/pages/home_screen.dart';
import '../../domain/entities/login_state.dart';
import '../providers/login_provider.dart';
import '../widgets/biometric_login_widget.dart';
import '../widgets/login_button.dart';
import '../widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(_fadeAnimation);

    _fadeController.forward();

    context.read<LoginProvider>().resetStateSilently();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  LoginState? _previousState;

  void _handleStateChange(LoginState state) {
    if (state == _previousState) return;
    _previousState = state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      switch (state) {
        case LoginSuccess():
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF43A047),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              ),
            );

          Future.delayed(const Duration(milliseconds: 800), () {
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          });

        case LoginError():
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFFE53935),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 3),
              ),
            );

        case LoginInitial():
        case LoginLoading():
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    final state = provider.state;
    final isLoading = state is LoginLoading;

    _handleStateChange(state);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 48),

                            _buildLogoSection(),

                            const SizedBox(height: 40),

                            _buildHeading(),

                            const SizedBox(height: 36),

                            _buildUsernameField(provider, isLoading),

                            const SizedBox(height: 20),

                            _buildPasswordField(provider, isLoading),

                            const SizedBox(height: 8),

                            _buildForgotPassword(),

                            const SizedBox(height: 28),

                            LoginButton(
                              text: 'login_btn'.tr(),
                              isLoading: isLoading,
                              onPressed: isLoading
                                  ? null
                                  : () => provider.login(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                      ),
                            ),

                            const Spacer(),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 32, top: 36),
                              child: BiometricLoginWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: appColors.brandOrange.withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'welcome_back'.tr(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: appColors.primaryText,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'login_subtitle'.tr(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: appColors.secondaryText,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField(LoginProvider provider, bool isLoading) {
    final error = provider.autoValidate
        ? provider.validateUsername(_usernameController.text)
        : null;

    return LoginTextField(
      controller: _usernameController,
      labelText: 'username'.tr(),
      hintText: 'username_hint'.tr(),
      prefixIcon: Iconsax.user,
      keyboardType: TextInputType.text,
      enabled: !isLoading,
      errorText: error,
      onChanged: (_) {

        if (provider.autoValidate) {
          provider.resetState();
        }
      },
    );
  }

  Widget _buildPasswordField(LoginProvider provider, bool isLoading) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    final error = provider.autoValidate
        ? provider.validatePassword(_passwordController.text)
        : null;

    return LoginTextField(
      controller: _passwordController,
      labelText: 'password'.tr(),
      hintText: 'password_hint'.tr(),
      prefixIcon: Iconsax.lock,
      obscureText: !provider.isPasswordVisible,
      enabled: !isLoading,
      errorText: error,
      onChanged: (_) {
        if (provider.autoValidate) {
          provider.resetState();
        }
      },
      suffixIcon: IconButton(
        onPressed: isLoading ? null : provider.togglePasswordVisibility,
        icon: Icon(
          provider.isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
          size: 20,
          color: appColors.iconDefault,
        ),
        splashRadius: 20,
      ),
    );
  }

  Widget _buildForgotPassword() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {

        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'forgot_password'.tr(),
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: appColors.brandOrange,
          ),
        ),
      ),
    );
  }
}