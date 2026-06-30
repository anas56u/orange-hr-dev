import 'package:flutter/material.dart';
import '../../domain/entities/category_detail.dart';
import '../../domain/usecases/get_category_detail_usecase.dart';

/// Provider that manages the state for [CategoryDetailScreen].
///
/// Loads sub-actions for a given category via the use case.
/// The UI remains "dumb" and reacts only to [notifyListeners].
class CategoryDetailProvider extends ChangeNotifier {
  final GetCategoryDetailUseCase _useCase;

  CategoryDetail? _categoryDetail;
  CategoryDetail? get categoryDetail => _categoryDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CategoryDetailProvider({required GetCategoryDetailUseCase useCase})
      // ignore: prefer_initializing_formals
      : _useCase = useCase;

  /// Loads the sub-actions for the category identified by [categoryTitle].
  void loadCategory(String categoryTitle) {
    _isLoading = true;
    notifyListeners();

    _categoryDetail = _useCase.execute(categoryTitle);

    _isLoading = false;
    notifyListeners();
  }
}
