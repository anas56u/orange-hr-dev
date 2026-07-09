import '../entities/category_detail.dart';

abstract class CategoryRepository {
  CategoryDetail? getCategoryDetail(String categoryTitle);
}