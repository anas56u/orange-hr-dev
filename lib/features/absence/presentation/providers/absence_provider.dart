import 'package:flutter/material.dart';

class AbsenceProvider extends ChangeNotifier {

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  String? _selectedType;

  String? get selectedType => _selectedType;

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  DateTime? _date;

  DateTime? get date => _date;

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  TimeOfDay? _fromTime;

  TimeOfDay? get fromTime => _fromTime;

  void setFromTime(TimeOfDay time) {
    _fromTime = time;
    notifyListeners();
  }

  TimeOfDay? _toTime;

  TimeOfDay? get toTime => _toTime;

  void setToTime(TimeOfDay time) {
    _toTime = time;
    notifyListeners();
  }

  String? get calculatedDuration {
    if (_fromTime == null || _toTime == null) return null;
    final fromMins = _fromTime!.hour * 60 + _fromTime!.minute;
    final toMins = _toTime!.hour * 60 + _toTime!.minute;
    var diff = toMins - fromMins;
    if (diff < 0) {
      diff += 24 * 60;
    }
    final hours = diff ~/ 60;
    final minutes = diff % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} HRS';
  }

  bool get canSubmit =>
      !_isSubmitting &&
      _selectedType != null &&
      _date != null &&
      _fromTime != null &&
      _toTime != null;

  Future<void> submitAbsence() async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    _selectedType = null;
    _date = null;
    _fromTime = null;
    _toTime = null;

    _isSubmitting = false;
    notifyListeners();
  }

  void resetForm() {
    _selectedType = null;
    _date = null;
    _fromTime = null;
    _toTime = null;
    notifyListeners();
  }
}