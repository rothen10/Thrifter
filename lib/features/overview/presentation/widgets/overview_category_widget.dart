// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widgets/paisa_empty_widget.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/main.dart';

class OverviewCategoryWidget extends StatelessWidget {
  const OverviewCategoryWidget({super.key, required this.builder});

  final Widget Function(Iterable<CategoryEntity> models) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CategoryModel>>(
      valueListenable: getIt<Box<CategoryModel>>().listenable(),
      builder: (context, expenseBox, _) {
        if (expenseBox.values.isEmpty) {
          return EmptyWidget(
            icon: Icons.paid,
            title: context.loc.emptyOverviewMessageTitle,
            description: context.loc.emptyOverviewMessageSubtitle,
          );
        }
        return builder(expenseBox.values.toEntities());
      },
    );
  }
}
