import 'package:flutter/material.dart';
import '../../domain/entities/offer_category.dart';
import '../../domain/usecases/get_offer_categories_usecase.dart';

/// Provider that manages the state for [LatestOffersScreen].
///
/// Loads offer categories via the use case and exposes them
/// reactively to the UI through [notifyListeners].
class LatestOffersProvider extends ChangeNotifier {
  final GetOfferCategoriesUseCase _useCase;

  List<OfferCategory> _categories = [];

  /// The currently loaded list of offer categories.
  List<OfferCategory> get categories => _categories;

  bool _isLoading = false;

  /// Whether the categories are currently being loaded.
  bool get isLoading => _isLoading;

  LatestOffersProvider({required GetOfferCategoriesUseCase useCase})
      // ignore: prefer_initializing_formals
      : _useCase = useCase;

  /// Loads all offer categories from the data layer.
  void loadCategories() {
    _isLoading = true;
    notifyListeners();

    _categories = _useCase.execute();

    _isLoading = false;
    notifyListeners();
  }
}
