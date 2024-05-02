// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/enum/transaction_type.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/home/presentation/controller/summary_controller.dart';
import 'package:thrifter/features/home/presentation/pages/home/home_cubit.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/expense_item_widget.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';

class AccountTransactionsPage extends StatelessWidget {
  const AccountTransactionsPage({
    super.key,
    required this.accountId,
    required this.summaryController,
  });

  final int accountId;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    context
        .read<AccountBloc>()
        .add(FetchAccountAndExpenseFromIdEvent(accountId));
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        appBar: context.materialYouAppBar(
          context.loc.transactionHistory,
          actions: [
            IconButton(
              tooltip: context.loc.edit,
              onPressed: () {
                AccountPageData(accountId: accountId).push(context);
              },
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              tooltip: context.loc.delete,
              onPressed: () {
                paisaAlertDialog(
                  context,
                  title: Text(
                    context.loc.dialogDeleteTitle,
                  ),
                  child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      if (state is AccountSelectedState) {
                        return RichText(
                          text: TextSpan(
                            text: context.loc.deleteAccount,
                            style: context.bodyMedium,
                            children: [
                              TextSpan(
                                text: state.accountEntity.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  confirmationButton: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {
                      context
                          .read<AccountBloc>()
                          .add(DeleteAccountEvent(accountId));
                      Navigator.pop(context);
                    },
                    child: Text(
                      context.loc.delete,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.delete_rounded),
            )
          ],
        ),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountDeletedState) {
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is AccountSelectedState) {
              if (state.transactions.isEmpty) {
                return EmptyWidget(
                  icon: Icons.credit_card,
                  title: context.loc.noTransaction,
                  description: context.loc.emptyAccountMessageSubTitle,
                );
              } else {
                return Scrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      final TransactionEntity expense =
                          state.transactions[index];
                      final CategoryEntity? category = context
                          .read<HomeCubit>()
                          .fetchCategoryFromId(expense.categoryId);
                      if (category == null) {
                        return const SizedBox.shrink();
                      } else {
                        return ExpenseItemWidget(
                          expense: expense,
                          account: state.accountEntity,
                          category: category,
                        );
                      }
                    },
                  ),
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PaisaIconButton(
                  onPressed: () {
                    TransactionPageData(
                      accountId: accountId,
                      transactionType: TransactionType.income,
                    ).push(context);
                  },
                  title: context.loc.income,
                  iconData: Icons.add_rounded,
                ),
                const SizedBox(
                  width: 8,
                ),
                PaisaIconButton(
                  onPressed: () {
                    TransactionPageData(
                      accountId: accountId,
                      transactionType: TransactionType.expense,
                    ).push(context);
                  },
                  title: context.loc.expense,
                  iconData: Icons.add_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
