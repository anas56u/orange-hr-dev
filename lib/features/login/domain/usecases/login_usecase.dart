/// Mock login use case.
///
/// Simulates a network request with a 2‑second delay and validates
/// against hardcoded credentials for quick UI testing.
class LoginUseCase {
  /// Hardcoded valid credentials for the mock scenario.
  static const _validPhone = '0791234567';
  static const _validPassword = 'password123';

  /// Simulates a login attempt.
  ///
  /// Returns `true` when [phone] and [password] match the hardcoded
  /// success credentials, `false` otherwise.
  Future<bool> execute({
    required String phone,
    required String password,
  }) async {
    // Simulate network latency.
    await Future.delayed(const Duration(seconds: 2));

    return phone == _validPhone && password == _validPassword;
  }
}
