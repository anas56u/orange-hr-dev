import 'package:local_auth/local_auth.dart';

abstract class BiometricLocalDataSource {
  Future<bool> authenticate();
}

class BiometricLocalDataSourceImpl implements BiometricLocalDataSource {
  final LocalAuthentication auth;
  BiometricLocalDataSourceImpl({required this.auth});

  @override
  Future<bool> authenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      if (!canAuthenticate) return false;

      return await auth.authenticate(
        localizedReason: 'قم باستخدام البصمة لتسجيل الدخول بأمان',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
        sensitiveTransaction: true,
      );
    } catch (e) {
      return false;
    }
  }
}
