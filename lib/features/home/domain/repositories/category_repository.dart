import '../entities/category_detail.dart';

/// Abstract repository contract for fetching category detail data.
///
/// The domain layer depends on this abstraction; the data layer
/// provides the concrete implementation.
abstract class CategoryRepository {
  CategoryDetail? getCategoryDetail(String categoryTitle);
}
