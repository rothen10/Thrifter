// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/constants/constants.dart';
import 'package:thrifter/core/extensions/build_context_extension.dart';
import 'package:thrifter/core/extensions/color_extension.dart';
import 'package:thrifter/features/category/presentation/bloc/category_bloc.dart';

class CategoryIconPickerWidget extends StatelessWidget {
  const CategoryIconPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryIconSelectedState ||
          current is CategorySuccessState,
      builder: (context, state) {
        int codePoint = MdiIcons.home.codePoint;
        if (state is CategoryIconSelectedState) {
          codePoint = state.categoryIcon;
        }
        if (state is CategorySuccessState) {
          codePoint = state.category.icon;
        }
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(context.loc.selectIconTitle),
          subtitle: Text(context.loc.selectIconSubTitle),
          leading: Icon(
            IconData(
              codePoint,
              fontFamily: fontFamilyName,
              fontPackage: fontFamilyPackageName,
            ),
            color: context.primary,
          ),
          onTap: () async {
            final IconData? result =
                await const CategoryIconPickerPageData().push(context);
            if (result == null) return;
            if (context.mounted) {
              context
                  .read<CategoryBloc>()
                  .add(CategoryIconSelectedEvent(result.codePoint));
            }
          },
        );
      },
    );
  }
}
