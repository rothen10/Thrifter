// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/category/domain/repository/category_repository.dart';

@lazySingleton
class GetDefaultCategoriesUseCase
    implements UseCase<List<CategoryEntity>, NoParams> {
  GetDefaultCategoriesUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  List<CategoryEntity> call(NoParams? params) {
    return categoryRepository.defaultCategories();
  }
}
