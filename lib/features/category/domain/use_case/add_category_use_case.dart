// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/category/domain/repository/category_repository.dart';

part 'add_category_use_case.freezed.dart';

@lazySingleton
class AddCategoryUseCase implements UseCase<void, AddCategoryParams> {
  AddCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Future<void> call(AddCategoryParams params) {
    return categoryRepository.add(
      name: params.name,
      desc: params.description,
      icon: params.icon,
      budget: params.budget,
      isBudget: params.isBudget,
      color: params.color,
      isDefault: params.isDefault,
    );
  }
}

@freezed
class AddCategoryParams with _$AddCategoryParams {
  const factory AddCategoryParams({
    required String name,
    double? budget,
    int? color,
    String? description,
    required int icon,
    @Default(false) bool isBudget,
    @Default(false) bool isDefault,
  }) = _AddCategoryParams;
}
