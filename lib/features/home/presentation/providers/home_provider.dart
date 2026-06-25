import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _currentBannerIndex = 0;
  
  int get currentBannerIndex => _currentBannerIndex;

  void updateBannerIndex(int index) {
    _currentBannerIndex = index;
    notifyListeners();
  }
  // 2. منطق الـ Bottom Navigation Bar الجديد
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  // دالة لتحديث التبويب النشط وإشعار الجزء المسؤول فقط في الـ UI
  void updateTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}