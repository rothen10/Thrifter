// Flutter imports:
import 'package:flutter/material.dart';
import 'package:thrifter/config/routes.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.categoryGrouped,
    required this.totalExpense,
  });

  final List<MapEntry<CategoryEntity, List<TransactionEntity>>> categoryGrouped;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoryGrouped.length,
      itemBuilder: (context, index) {
        final MapEntry<CategoryEntity, List<TransactionEntity>> map =
            categoryGrouped[index];
        final Color color = Color(map.key.color);
        return InkWell(
          onTap: () {
            TransactionsByCategoryPageData(map.key.superId!).push(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        backgroundColor: color.withOpacity(0.12),
                        child: Icon(
                          size: 18,
                          color: color,
                          IconData(
                            map.key.icon,
                            fontFamily: fontFamilyName,
                            fontPackage: fontFamilyPackageName,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(map.key.name),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: map.value.total / totalExpense,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      map.value.total.toFormateCurrency(context),
                      style: context.bodyMedium?.copyWith(),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
