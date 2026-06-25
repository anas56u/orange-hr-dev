import 'package:flutter/material.dart';
import '../../domain/usecases/init_app_usecase.dart';

class SplashProvider extends ChangeNotifier {
  final InitAppUseCase initAppUseCase;

  SplashProvider({required this.initAppUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initializeApp() async {
    _isLoading = true;
    notifyListeners();
    await initAppUseCase.execute();
    
    _isLoading = false;
    notifyListeners(); 
  }
}