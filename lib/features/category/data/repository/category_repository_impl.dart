// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/category/data/data_sources/category_data_source.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/category/domain/repository/category_repository.dart';
import 'package:thrifter/features/transaction/data/data_sources/local/transaction_data_manager.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({
    required this.dataSources,
    required this.expenseDataManager,
  });

  final CategoryDataSource dataSources;
  final TransactionDataSource expenseDataManager;

  @override
  Future<void> add({
    required String name,
    required int icon,
    required int? color,
    required String? desc,
    bool isBudget = false,
    required double? budget,
    bool isDefault = false,
  }) {
    return dataSources.add(CategoryModel(
      description: desc ?? '',
      name: name,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      color: color,
      isDefault: isDefault,
    ));
  }

  @override
  Future<void> clear() => dataSources.clear();

  @override
  List<CategoryEntity> defaultCategories() {
    return dataSources.defaultCategories().toEntities();
  }

  @override
  Future<void> delete(int key) => dataSources.delete(key);

  @override
  CategoryEntity? fetchById(int categoryId) =>
      dataSources.findById(categoryId)?.toEntity();

  @override
  Future<void> update({
    required int? key,
    required String name,
    required int icon,
    required int? color,
    required String? desc,
    bool isBudget = false,
    required double? budget,
    bool isDefault = false,
  }) {
    return dataSources.update(CategoryModel(
      description: desc,
      name: name,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      isDefault: isDefault,
      color: color,
      superId: key,
    ));
  }
}
