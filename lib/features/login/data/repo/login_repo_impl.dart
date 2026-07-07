import 'package:orange_hr_dev/features/login/data/datasources/biometric_local_data_source.dart';
import 'package:orange_hr_dev/features/login/domain/repo/login_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final BiometricLocalDataSource biometricDataSource;

  LoginRepositoryImpl({required this.biometricDataSource});

  @override
  Future<bool> loginWithBiometrics() async {
    return await biometricDataSource.authenticate();
  }
}
