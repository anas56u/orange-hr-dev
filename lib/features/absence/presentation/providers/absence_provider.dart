import 'package:flutter/material.dart';

/// Manages the state of the "Submit Absence" form.
///
/// Tracks the selected absence type, date, from-time, and to-time.
/// Exposes a [canSubmit] convenience getter that returns true only
/// when every required field has a value.
///
/// The provider is scoped to [AbsenceManagementScreen] via a local
/// [ChangeNotifierProvider] and auto-disposes when the screen is popped.
class AbsenceProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Submission Loading State
  // ---------------------------------------------------------------------------

  bool _isSubmitting = false;

  /// Returns `true` while the absence submission is in progress.
  bool get isSubmitting => _isSubmitting;

  // ---------------------------------------------------------------------------
  // Absence Type
  // ---------------------------------------------------------------------------

  String? _selectedType;

  /// The currently selected absence type, or `null` if none chosen.
  String? get selectedType => _selectedType;

  /// Updates the selected type and notifies listeners.
  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Date
  // ---------------------------------------------------------------------------

  DateTime? _date;

  /// The chosen date, or `null` if not yet picked.
  DateTime? get date => _date;

  /// Updates the date and notifies listeners.
  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // From Time
  // ---------------------------------------------------------------------------

  TimeOfDay? _fromTime;

  /// The chosen start time, or `null` if not yet picked.
  TimeOfDay? get fromTime => _fromTime;

  /// Updates the start time and notifies listeners.
  void setFromTime(TimeOfDay time) {
    _fromTime = time;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // To Time
  // ---------------------------------------------------------------------------

  TimeOfDay? _toTime;

  /// The chosen end time, or `null` if not yet picked.
  TimeOfDay? get toTime => _toTime;

  /// Updates the end time and notifies listeners.
  void setToTime(TimeOfDay time) {
    _toTime = time;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Derived state
  // ---------------------------------------------------------------------------

  /// Returns the formatted duration between [fromTime] and [toTime]
  /// (e.g. `01:45 HRS`), or `null` if either time is not yet selected.
  String? get calculatedDuration {
    if (_fromTime == null || _toTime == null) return null;
    final fromMins = _fromTime!.hour * 60 + _fromTime!.minute;
    final toMins = _toTime!.hour * 60 + _toTime!.minute;
    var diff = toMins - fromMins;
    if (diff < 0) {
      diff += 24 * 60; // handle overnight shifts gracefully
    }
    final hours = diff ~/ 60;
    final minutes = diff % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} HRS';
  }

  /// Returns `true` when every required field has a value and not currently submitting,
  /// enabling the submit button.
  bool get canSubmit =>
      !_isSubmitting &&
      _selectedType != null &&
      _date != null &&
      _fromTime != null &&
      _toTime != null;

  /// Executes the submission logic asynchronously.
  /// Sets loading state, simulates network request/repository call, resets form, and returns.
  Future<void> submitAbsence() async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    notifyListeners();

    // Simulate async submission logic (e.g. API/Repository call)
    await Future.delayed(const Duration(milliseconds: 1000));

    // Reset fields upon successful submission
    _selectedType = null;
    _date = null;
    _fromTime = null;
    _toTime = null;

    _isSubmitting = false;
    notifyListeners();
  }

  /// Resets every field back to its initial empty state.
  void resetForm() {
    _selectedType = null;
    _date = null;
    _fromTime = null;
    _toTime = null;
    notifyListeners();
  }
}
