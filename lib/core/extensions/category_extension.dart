// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';

extension CategoryModelHelper on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      icon: icon,
      name: name,
      color: color ?? Colors.amber.shade100.value,
      budget: budget,
      description: description,
      isBudget: isBudget,
      superId: superId,
      isDefault: isDefault,
    );
  }
}

extension CategoryModelsHelper on Iterable<CategoryModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  Iterable<CategoryModel> sort() => sorted((a, b) => a.name.compareTo(b.name));

  Iterable<CategoryModel> get filterDefault {
    return sort().where((element) => !element.isDefault);
  }

  List<CategoryEntity> toEntities() =>
      sort().map((categoryModel) => categoryModel.toEntity()).toList();

  List<CategoryEntity> toBudgetEntities() => sort()
      .map((categoryModel) => categoryModel.toEntity())
      .where((element) => element.isBudget)
      .toList();
}

extension CategoryHelper on CategoryEntity {
  Color get foregroundColor => Color(color);
  Color get backgroundColor => Color(color).withOpacity(0.25);
  double get finalBudget => budget ?? 0.0;
}
