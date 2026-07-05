import 'package:flutter/material.dart';
import '../../domain/entities/app_language.dart';
import '../../domain/usecases/change_language_usecase.dart';

class SettingsProvider extends ChangeNotifier {
  final ChangeLanguageUseCase changeLanguageUseCase;

  SettingsProvider({required this.changeLanguageUseCase});

  Future<void> updateLanguage(BuildContext context, AppLanguage language) async {
    await changeLanguageUseCase.execute(context, language.locale);
    notifyListeners();
  }
}
