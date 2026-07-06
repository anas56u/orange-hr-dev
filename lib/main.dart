import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/features/home/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

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

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      useOnlyLangCode: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashProvider(initAppUseCase: InitAppUseCase()),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(loginUseCase: LoginUseCase()),
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            final provider = SettingsProvider(
              changeLanguageUseCase: ChangeLanguageUseCase(
                SettingsRepositoryImpl(),
              ),
            );
            return provider;
          },
        ),
      ],
     
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return MaterialApp(
            title: 'Orange HR',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            // KEY CHANGE: locale now comes from the provider.
            // When settingsProvider.notifyListeners() fires,
            // this Consumer rebuilds, passing the NEW locale
            // to MaterialApp — causing the entire app to
            // re-render with the new language.
            locale: settingsProvider.locale,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

