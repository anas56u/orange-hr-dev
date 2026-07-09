import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/home/presentation/pages/home_screen.dart';
import 'package:orange_hr_dev/features/login/domain/usecases/biometric_login_usecase.dart';

import '../../domain/entities/login_state.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final BiometricLoginUsecase biometricLoginUseCase;

  LoginProvider({
    required this.loginUseCase,
    required this.biometricLoginUseCase,
  });

  LoginState _state = const LoginInitial();
  LoginState get state => _state;
  bool _isLoadingBiometric = false;
  bool get isLoadingBiometric => _isLoadingBiometric;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _autoValidate = false;
  bool get autoValidate => _autoValidate;

  Future<void> authenticateWithBiometric(BuildContext context) async {
    _isLoadingBiometric = true;
    notifyListeners();
    try{
      final isSuccess = await biometricLoginUseCase();
      _isLoadingBiometric = false;
      notifyListeners();
      if (isSuccess && context.mounted){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }catch(e){
      _isLoadingBiometric = false;
      notifyListeners();
    }

  }

  String? validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return 'username_required'.tr();
    }
    if (username.trim().length < 3) {
      return 'username_invalid'.tr();
    }
    return null;
  }

  String? validatePhone(String? phone) => validateUsername(phone);

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'password_required'.tr();
    }
    if (password.length < 6) {
      return 'password_length'.tr();
    }
    return null;
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void resetState() {
    _state = const LoginInitial();
    notifyListeners();
  }

  void resetStateSilently() {
    _state = const LoginInitial();
    _autoValidate = false;
  }

  void logout() {
    _state = const LoginInitial();
    _autoValidate = false;
    notifyListeners();
  }

  Future<void> login({String? username, String? phone, required String password}) async {
    final user = (username ?? phone ?? '').trim();

    _autoValidate = true;
    notifyListeners();

    final userError = validateUsername(user);
    final passwordError = validatePassword(password);

    if (userError != null || passwordError != null) {

      return;
    }

    _state = const LoginLoading();
    notifyListeners();

    try {
      final success = await loginUseCase.execute(
        username: user,
        password: password,
      );

      if (success) {
        _state = LoginSuccess(message: 'login_success'.tr());
      } else {
        _state = LoginError(message: 'login_error'.tr());
      }
    } catch (e) {
      _state = LoginError(
        message: 'something_went_wrong'.tr(args: [e.toString()]),
      );
    }

    notifyListeners();
  }
}