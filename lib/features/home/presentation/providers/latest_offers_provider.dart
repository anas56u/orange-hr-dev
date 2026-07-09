import 'package:flutter/material.dart';
import '../../domain/entities/offer_category.dart';
import '../../domain/usecases/get_offer_categories_usecase.dart';

class LatestOffersProvider extends ChangeNotifier {
  final GetOfferCategoriesUseCase _useCase;

  List<OfferCategory> _categories = [];

  List<OfferCategory> get categories => _categories;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  LatestOffersProvider({required GetOfferCategoriesUseCase useCase})

      : _useCase = useCase;

  void loadCategories() {
    _isLoading = true;
    notifyListeners();

    _categories = _useCase.execute();

    _isLoading = false;
    notifyListeners();
  }
}