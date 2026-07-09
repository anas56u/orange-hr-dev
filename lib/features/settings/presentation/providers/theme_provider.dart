import 'package:flutter/material.dart';

import '../../domain/entities/app_theme_mode.dart';
import '../../domain/usecases/change_theme_usecase.dart';
import '../../domain/usecases/get_theme_usecase.dart';

class ThemeProvider extends ChangeNotifier {
  final GetThemeUseCase _getThemeUseCase;
  final ChangeThemeUseCase _changeThemeUseCase;

  AppThemeMode _appThemeMode = AppThemeMode.system;

  ThemeProvider({
    required GetThemeUseCase getThemeUseCase,
    required ChangeThemeUseCase changeThemeUseCase,
  }) : _getThemeUseCase = getThemeUseCase,
       _changeThemeUseCase = changeThemeUseCase;

  ThemeMode get themeMode => _appThemeMode.toThemeMode();

  AppThemeMode get appThemeMode => _appThemeMode;

  bool get isDarkMode => _appThemeMode == AppThemeMode.dark;

  void loadTheme() {
    _appThemeMode = _getThemeUseCase.execute();

  }

  Future<void> changeTheme(AppThemeMode mode) async {
    if (_appThemeMode == mode) return;

    _appThemeMode = mode;
    notifyListeners();

    await _changeThemeUseCase.execute(mode);
  }

  Future<void> toggleDarkMode() async {
    final newMode =
        _appThemeMode == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;
    await changeTheme(newMode);
  }
}