/// All possible states for the login screen UI.
///
/// Sealed so that `switch` expressions are exhaustive — the compiler
/// guarantees every state is handled in the presentation layer.
sealed class LoginState {
  const LoginState();
}

/// The initial idle state — form is ready for input.
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// A login request is in‑flight (mock network call running).
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// The login succeeded.
class LoginSuccess extends LoginState {
  final String message;
  const LoginSuccess({this.message = 'Login successful!'});
}

/// The login failed with a user‑facing [message].
class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
}
