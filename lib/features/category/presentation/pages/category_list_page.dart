// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/category/presentation/bloc/category_bloc.dart';
import 'package:thrifter/features/category/presentation/pages/category_list_mobile_page.dart';
import 'package:thrifter/features/category/presentation/pages/category_list_tablet_page.dart';
import 'package:thrifter/main.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<CategoryBloc>();
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        body: ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: getIt<Box<CategoryModel>>().listenable(),
          builder: (BuildContext context, value, Widget? child) {
            if (value.values.isEmpty) {
              return EmptyWidget(
                title: context.loc.emptyCategoriesMessageTitle,
                description: context.loc.emptyCategoriesMessageSubTitle,
                icon: Icons.category,
              );
            }
            final List<CategoryEntity> categories = value.values.toEntities();
            return ScreenTypeLayout.builder(
              mobile: (p0) => CategoryListMobileWidget(
                categories: categories,
              ),
              tablet: (p0) => CategoryListTabletWidget(
                addCategoryBloc: bloc,
                crossAxisCount: 3,
                categories: categories,
              ),
              desktop: (p0) => CategoryListTabletWidget(
                addCategoryBloc: bloc,
                crossAxisCount: 5,
                categories: categories,
              ),
            );
          },
        ),
      ),
    );
  }
}
