import '../entities/category_detail.dart';
import '../repositories/category_repository.dart';

class GetCategoryDetailUseCase {
  final CategoryRepository repository;

  const GetCategoryDetailUseCase({required this.repository});

  CategoryDetail? execute(String categoryTitle) {
    return repository.getCategoryDetail(categoryTitle);
  }
}