import 'package:flutter/foundation.dart';
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
      debugPrint('🔐 canCheckBiometrics: $canAuthenticateWithBiometrics');

      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      debugPrint('🔐 canAuthenticate: $canAuthenticate');

      if (!canAuthenticate) {
        debugPrint('🔐 Device does not support biometric authentication');
        return false;
      }

      final result = await auth.authenticate(
        localizedReason: 'قم باستخدام البصمة لتسجيل الدخول بأمان',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
        sensitiveTransaction: true,
      );
      debugPrint('🔐 authenticate result: $result');
      return result;
    } catch (e) {
      debugPrint('🔐 Biometric error: $e');
      return false;
    }
  }
}