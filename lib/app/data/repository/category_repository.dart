import 'package:my_finance_apps/app/data/models/category_model.dart';
import 'package:my_finance_apps/app/data/providers/category_provider.dart';

class CategoryRepository {
  CategoryProvider categoryProvider;
  CategoryRepository(this.categoryProvider);

  Future<void> createCategory(Category category) {
    return categoryProvider.createCategory(category);
  }

  Future<List<Category?>> readCategories() {
    return Future.delayed(const Duration(seconds: 1), () {
      return categoryProvider.readCategories();
    });
  }
}
