// Project imports:
import 'package:thrifter/features/category/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<void> add({
    required String name,
    required int icon,
    required int? color,
    required String? desc,
    bool isBudget = false,
    required double? budget,
    bool isDefault = false,
  });

  Future<void> delete(int key);

  CategoryEntity? fetchById(int categoryId);

  Future<void> update({
    required int? key,
    required String name,
    required int icon,
    required int? color,
    required String? desc,
    bool isBudget = false,
    required double? budget,
    bool isDefault = false,
  });

  Future<void> clear();

  List<CategoryEntity> defaultCategories();
}
