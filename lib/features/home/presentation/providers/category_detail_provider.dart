import 'package:flutter/material.dart';
import '../../domain/entities/category_detail.dart';
import '../../domain/usecases/get_category_detail_usecase.dart';

class CategoryDetailProvider extends ChangeNotifier {
  final GetCategoryDetailUseCase _useCase;

  CategoryDetail? _categoryDetail;
  CategoryDetail? get categoryDetail => _categoryDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CategoryDetailProvider({required GetCategoryDetailUseCase useCase})

      : _useCase = useCase;

  void loadCategory(String categoryTitle) {
    _isLoading = true;
    notifyListeners();

    _categoryDetail = _useCase.execute(categoryTitle);

    _isLoading = false;
    notifyListeners();
  }
}