import 'package:flutter/material.dart';

class AbsenceProvider extends ChangeNotifier {
  String? _selectedType;

  String? get selectedType => _selectedType;

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }
}
