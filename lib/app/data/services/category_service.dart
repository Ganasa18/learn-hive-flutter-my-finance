// ignore_for_file: avoid_print

import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/core/values/keys.dart';
import 'package:my_finance_apps/app/data/models/category_model.dart';

class CategoryStorageService {
  late Box<Category> _categoryBox;
  List<dynamic> categoryList = [];

  Future<void> init() async {
    try {
      // Initialize Hive and open the box for category
      if (!Hive.isAdapterRegistered(CategoryAdapter().typeId)) {
        // If it's not registered, then register the adapter
        Hive.registerAdapter(CategoryAdapter());
      }
      _categoryBox = await Hive.openBox<Category>(categoryKey);
    } catch (e) {
      // Handle errors, such as Hive initialization or box opening failure.
      print('Error initializing user storage: $e');
    }
  }

  Future<void> createCategory(Category category) async {
    await _categoryBox.add(category);

    // final existingCategory = _categoryBox.values.firstWhere(
    //   (existing) => existing.nameCategory == category.nameCategory,
    //   orElse: () => Category(idCategory: 0, nameCategory: '', iconCategory: 0),
    // );
    // if (existingCategory.nameCategory == category.nameCategory) {
    //   print('Category with the same name already exists.');
    // } else {
    //   await _categoryBox.add(category);
    // }
  }

  Future<List<Category>> readCategories() async {
    final categoryList = _categoryBox.values.toList();
    return categoryList;
  }
}
