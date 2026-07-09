class LoginUseCase {

  static const _validUsername = 'admin';
  static const _validPassword = 'password123';

  Future<bool> execute({
    required String username,
    required String password,
  }) async {

    await Future.delayed(const Duration(seconds: 2));

    final cleanUser = username.trim().toLowerCase();
    return (cleanUser == _validUsername || cleanUser == 'anas') &&
        password == _validPassword;
  }
}