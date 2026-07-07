import 'package:orange_hr_dev/features/login/domain/repo/login_repo.dart';

class BiometricLoginUsecase {
  final LoginRepository repository;
  BiometricLoginUsecase({required this.repository});
  Future<bool> call() async {
    return await repository.loginWithBiometrics();
  }
}