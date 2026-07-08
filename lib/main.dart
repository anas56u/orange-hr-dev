import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:local_auth/local_auth.dart';
import 'package:orange_hr_dev/core/theme/app_themes.dart';
import 'package:orange_hr_dev/features/home/presentation/providers/home_provider.dart';
import 'package:orange_hr_dev/features/login/data/datasources/biometric_local_data_source.dart';
import 'package:orange_hr_dev/features/login/data/repo/login_repo_impl.dart';
import 'package:orange_hr_dev/features/login/domain/usecases/biometric_login_usecase.dart';
import 'package:orange_hr_dev/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:orange_hr_dev/features/settings/domain/usecases/change_theme_usecase.dart';
import 'package:orange_hr_dev/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:orange_hr_dev/features/settings/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/providers/login_provider.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/usecases/change_language_usecase.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/splash/domain/usecases/init_app_usecase.dart';
import 'features/splash/presentation/providers/splash_provider.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      useOnlyLangCode: false,
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashProvider(initAppUseCase: InitAppUseCase()),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            loginUseCase: LoginUseCase(),
            biometricLoginUseCase: BiometricLoginUsecase(
              repository: LoginRepositoryImpl(
                biometricDataSource: BiometricLocalDataSourceImpl(
                  auth: LocalAuthentication(),
                ),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            final themeDataSource = ThemeLocalDataSource(prefs: prefs);
            final settingsRepository = SettingsRepositoryImpl(
              themeDataSource: themeDataSource,
            );
            final provider = SettingsProvider(
              changeLanguageUseCase: ChangeLanguageUseCase(settingsRepository),
            );
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            final themeDataSource = ThemeLocalDataSource(prefs: prefs);
            final settingsRepository = SettingsRepositoryImpl(
              themeDataSource: themeDataSource,
            );
            final provider = ThemeProvider(
              getThemeUseCase: GetThemeUseCase(settingsRepository),
              changeThemeUseCase: ChangeThemeUseCase(settingsRepository),
            );
            provider.loadTheme();
            return provider;
          },
        ),
      ],

      child: Builder(
        builder: (context) {
          final themeMode = context.select<ThemeProvider, ThemeMode>(
            (p) => p.themeMode,
          );
          return MaterialApp(
            title: 'Orange HR',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,

            locale: context.locale,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
  