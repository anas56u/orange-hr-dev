import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/splash/domain/usecases/init_app_usecase.dart';
import 'features/splash/presentation/providers/splash_provider.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        title: 'Orange HR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
