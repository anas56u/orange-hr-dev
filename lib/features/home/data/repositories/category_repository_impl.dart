import '../../domain/entities/category_detail.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';

/// Concrete implementation of [CategoryRepository].
///
/// Delegates to [CategoryLocalDataSource] for data retrieval.
/// In the future, this could be swapped to fetch from an API
/// without touching the domain or presentation layers.
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _dataSource;

  const CategoryRepositoryImpl({required CategoryLocalDataSource dataSource})
      // ignore: prefer_initializing_formals
      : _dataSource = dataSource;

  @override
  CategoryDetail? getCategoryDetail(String categoryTitle) {
    return _dataSource.getCategoryDetail(categoryTitle);
  }
}
