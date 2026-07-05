import 'package:flutter/foundation.dart';

import '../../domain/entities/login_state.dart';
import '../../domain/usecases/login_usecase.dart';

/// Manages all login‑related state and exposes it to the UI
/// via [ChangeNotifier].
class LoginProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginProvider({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase;


  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  LoginState _state = const LoginInitial();
  LoginState get state => _state;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  /// Turns on auto‑validation after the first submit attempt so that
  /// the user isn't bombarded with errors before they even try.
  bool _autoValidate = false;
  bool get autoValidate => _autoValidate;

  // ---------------------------------------------------------------------------
  // Validation helpers
  // ---------------------------------------------------------------------------

  /// Jordanian mobile: starts with `07`, exactly 10 digits.
  static final _phoneRegex = RegExp(r'^07\d{8}$');

  /// Returns an error string if [phone] is invalid, `null` otherwise.
  String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!_phoneRegex.hasMatch(phone.trim())) {
      return 'Enter a valid Jordanian mobile (07XXXXXXXX)';
    }
    return null;
  }

  /// Returns an error string if [password] is invalid, `null` otherwise.
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
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

  /// Validates the form and, if valid, fires the mock login use case.
  ///
  /// The caller should pass the current text‑field values. Returns early
  /// (with an [LoginError] state) when validation fails.
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    // Enable inline validation from this point on.
    _autoValidate = true;
    notifyListeners();

    // ---- client‑side validation ----
    final phoneError = validatePhone(phone);
    final passwordError = validatePassword(password);

    if (phoneError != null || passwordError != null) {
      // Don't call the use case — the form‑level errors are enough.
      return;
    }

    // ---- fire mock network request ----
    _state = const LoginLoading();
    notifyListeners();

    try {
      final success = await _loginUseCase.execute(
        phone: phone.trim(),
        password: password,
      );

      if (success) {
        _state = const LoginSuccess();
      } else {
        _state = const LoginError(
          message: 'Invalid phone number or password. Please try again.',
        );
      }
    } catch (e) {
      _state = LoginError(message: 'Something went wrong: $e');
    }

    notifyListeners();
  }
}
