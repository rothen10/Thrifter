// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Project imports:
import 'package:thrifter/core/constants/constants.dart';
import 'package:thrifter/core/extensions/build_context_extension.dart';
import 'package:thrifter/core/extensions/category_extension.dart';
import 'package:thrifter/core/extensions/color_extension.dart';
import 'package:thrifter/core/extensions/text_style_extension.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/category/data/data_sources/default_category.dart';
import 'package:thrifter/features/category/data/data_sources/category_data_source.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/intro/presentation/widgets/intro_image_picker_widget.dart';
import 'package:thrifter/main.dart';

class IntroCategoryAddWidget extends StatefulWidget {
  const IntroCategoryAddWidget({super.key});

  @override
  State<IntroCategoryAddWidget> createState() => _IntroCategoryAddWidgetState();
}

class _IntroCategoryAddWidgetState extends State<IntroCategoryAddWidget>
    with AutomaticKeepAliveClientMixin {
  final CategoryDataSource dataSource = getIt<CategoryDataSource>();
  final List<CategoryModel> defaultModels = defaultCategoriesData();

  @override
  void initState() {
    super.initState();
    for (var element in getIt<Box<CategoryModel>>().values.filterDefault) {
      defaultModels.remove(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<Box<CategoryModel>>(
      valueListenable: getIt<Box<CategoryModel>>().listenable(),
      builder: (context, value, child) {
        final List<CategoryModel> categoryModels =
            value.values.filterDefault.toList();
        return PaisaAnnotatedRegionWidget(
          color: context.background,
          child: Scaffold(
            body: ListView(
              children: [
                IntroTopWidget(
                  title: context.loc.addCategory,
                  icon: Icons.category,
                ),
                Builder(
                  builder: (context) {
                    return ScreenTypeLayout.builder(
                      mobile: (p0) => PaisaFilledCard(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              Divider(color: Theme.of(context).dividerColor),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryModels.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final CategoryModel model = categoryModels[index];
                            return CategoryItemWidget(
                              model: model,
                              onPress: () async {
                                await model.delete();
                                defaultModels.add(model);
                              },
                            );
                          },
                        ),
                      ),
                      tablet: (p0) => GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryModels.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final CategoryModel model = categoryModels[index];
                          return CategoryItemWidget(
                            model: model,
                            onPress: () async {
                              await model.delete();
                              defaultModels.add(model);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    context.loc.recommendedCategories,
                    style: context.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: defaultModels
                        .sorted((a, b) => a.name.compareTo(b.name))
                        .map((model) => FilterChip(
                              label: Text(model.name),
                              onSelected: (value) {
                                dataSource.add(model);
                                setState(() {
                                  defaultModels.remove(model);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                                side: BorderSide(
                                  color: context.primary,
                                ),
                              ),
                              showCheckmark: false,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              labelStyle: context.titleMedium,
                              padding: const EdgeInsets.all(12),
                              avatar: Icon(
                                IconData(
                                  model.icon,
                                  fontFamily: fontFamilyName,
                                  fontPackage: fontFamilyPackageName,
                                ),
                                color: context.primary,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.model,
    required this.onPress,
  });

  final CategoryModel model;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (p0) => ListTile(
        onTap: onPress,
        leading: Icon(
          IconData(
            model.icon,
            fontFamily: fontFamilyName,
            fontPackage: fontFamilyPackageName,
          ),
          color: Color(model.color ?? Colors.brown.shade200.value),
        ),
        title: Text(model.name),
        trailing: Icon(MdiIcons.delete),
      ),
      tablet: (p0) => PaisaCard(
        child: InkWell(
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    IconData(
                      model.icon,
                      fontFamily: fontFamilyName,
                      fontPackage: fontFamilyPackageName,
                    ),
                    color: Color(model.color ?? Colors.brown.shade200.value),
                  ),
                ),
                Expanded(
                  child: Text(
                    model.name,
                    style: context.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
