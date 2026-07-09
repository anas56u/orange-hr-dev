import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/home/presentation/pages/home_screen.dart';
import 'package:orange_hr_dev/features/login/domain/usecases/biometric_login_usecase.dart';

import '../../domain/entities/login_state.dart';
import '../../domain/usecases/login_usecase.dart';

/// Manages all login‑related state and exposes it to the UI
/// via [ChangeNotifier].
class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final BiometricLoginUsecase biometricLoginUseCase;

  LoginProvider({
    required this.loginUseCase,
    required this.biometricLoginUseCase,
  });

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  LoginState _state = const LoginInitial();
  LoginState get state => _state;
  bool _isLoadingBiometric = false;
  bool get isLoadingBiometric => _isLoadingBiometric;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  /// Turns on auto‑validation after the first submit attempt so that
  /// the user isn't bombarded with errors before they even try.
  bool _autoValidate = false;
  bool get autoValidate => _autoValidate;

  // ---------------------------------------------------------------------------
  // Validation helpers
  // ---------------------------------------------------------------------------

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

  /// Returns an error string if [username] is invalid, `null` otherwise.
  String? validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return 'username_required'.tr();
    }
    if (username.trim().length < 3) {
      return 'username_invalid'.tr();
    }
    return null;
  }

  /// Backward-compatible alias.
  String? validatePhone(String? phone) => validateUsername(phone);

  /// Returns an error string if [password] is invalid, `null` otherwise.
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'password_required'.tr();
    }
    if (password.length < 6) {
      return 'password_length'.tr();
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// Toggles the password field between obscured / visible.
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Resets back to the initial idle state (e.g. to clear a previous error).
  void resetState() {
    _state = const LoginInitial();
    notifyListeners();
  }

  /// Silently resets the state without calling notifyListeners (safe for initState).
  void resetStateSilently() {
    _state = const LoginInitial();
    _autoValidate = false;
  }

  /// Logs out the user and clears persistent/in-memory login state.
  void logout() {
    _state = const LoginInitial();
    _autoValidate = false;
    notifyListeners();
  }

  /// Validates the form and, if valid, fires the mock login use case.
  ///
  /// The caller should pass the current text‑field values. Returns early
  /// (with an [LoginError] state) when validation fails.
  Future<void> login({String? username, String? phone, required String password}) async {
    final user = (username ?? phone ?? '').trim();

    // Enable inline validation from this point on.
    _autoValidate = true;
    notifyListeners();

    // ---- client‑side validation ----
    final userError = validateUsername(user);
    final passwordError = validatePassword(password);

    if (userError != null || passwordError != null) {
      // Don't call the use case — the form‑level errors are enough.
      return;
    }

    // ---- fire mock network request ----
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
