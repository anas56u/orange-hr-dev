import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _currentBannerIndex = 0;

  int get currentBannerIndex => _currentBannerIndex;

  void updateBannerIndex(int index) {
    _currentBannerIndex = index;
    notifyListeners();
  }

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void updateTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}