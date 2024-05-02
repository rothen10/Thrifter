// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/home/presentation/pages/home/home_cubit.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/expense_item_widget.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';

class TransactionByCategoryPage extends StatelessWidget {
  const TransactionByCategoryPage({
    super.key,
    required this.categoryId,
  });

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final List<TransactionEntity> expenses =
        context.read<HomeCubit>().fetchExpensesFromCategoryId(categoryId);

    return PaisaAnnotatedRegionWidget(
      color: Colors.transparent,
      child: Scaffold(
        extendBody: true,
        appBar: context.materialYouAppBar(context.loc.transactionsByCategory),
        bottomNavigationBar: SafeArea(
          child: PaisaFilledCard(
            child: ListTile(
              title: Text(
                context.loc.total,
                style: context.titleSmall
                    ?.copyWith(color: context.onSurfaceVariant),
              ),
              subtitle: Text(
                expenses.fullTotal.toFormateCurrency(context),
                style: context.titleMedium?.copyWith(
                  color: context.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: expenses.length,
          itemBuilder: (BuildContext context, int index) {
            final AccountEntity? account = context
                .read<HomeCubit>()
                .fetchAccountFromId(expenses[index].accountId);
            final CategoryEntity? category = context
                .read<HomeCubit>()
                .fetchCategoryFromId(expenses[index].categoryId);
            if (account == null || category == null) {
              return const SizedBox.shrink();
            }
            return ExpenseItemWidget(
              expense: expenses[index],
              account: account,
              category: category,
            );
          },
        ),
      ),
    );
  }
}
