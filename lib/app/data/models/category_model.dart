import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  int idCategory;
  @HiveField(1)
  String nameCategory;
  @HiveField(2)
  int iconCategory;
  Category({
    required this.idCategory,
    required this.nameCategory,
    required this.iconCategory,
  });

  Category copyWith({
    int? idCategory,
    String? nameCategory,
    int? iconCategory,
  }) {
    return Category(
      idCategory: idCategory ?? this.idCategory,
      nameCategory: nameCategory ?? this.nameCategory,
      iconCategory: iconCategory ?? this.iconCategory,
    );
  }
}
