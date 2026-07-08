import '../entities/category_detail.dart';
import '../repositories/category_repository.dart';

/// Use case that retrieves the detail (sub-actions) for a given category.
///
/// Takes the category's display title and returns a [CategoryDetail]
/// if sub-actions are defined, or `null` for categories without data yet.
class GetCategoryDetailUseCase {
  final CategoryRepository repository;

  const GetCategoryDetailUseCase({required this.repository});

  CategoryDetail? execute(String categoryTitle) {
    return repository.getCategoryDetail(categoryTitle);
  }
}