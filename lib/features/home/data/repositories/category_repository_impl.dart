import '../../domain/entities/category_detail.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _dataSource;

  const CategoryRepositoryImpl({required CategoryLocalDataSource dataSource})

      : _dataSource = dataSource;

  @override
  CategoryDetail? getCategoryDetail(String categoryTitle) {
    return _dataSource.getCategoryDetail(categoryTitle);
  }
}