import 'package:my_finance_apps/app/data/models/category_model.dart';
import 'package:my_finance_apps/app/data/services/category_service.dart';

class CategoryProvider {
  CategoryStorageService categoryStorageService;
  CategoryProvider(this.categoryStorageService);

  Future<void> createCategory(Category category) {
    return categoryStorageService.createCategory(category);
  }

  Future<List<Category?>> readCategories() {
    return categoryStorageService.readCategories();
  }
}
