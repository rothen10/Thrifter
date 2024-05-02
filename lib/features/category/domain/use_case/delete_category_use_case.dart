// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/category/domain/repository/category_repository.dart';

part 'delete_category_use_case.freezed.dart';

@lazySingleton
class DeleteCategoryUseCase
    implements UseCase<Future<void>, DeleteCategoryParams> {
  DeleteCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Future<void> call(DeleteCategoryParams params) {
    return categoryRepository.delete(params.categoryId);
  }
}

@freezed
class DeleteCategoryParams with _$DeleteCategoryParams {
  const factory DeleteCategoryParams(int categoryId) = _DeleteCategoryParams;
}
