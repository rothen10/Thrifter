// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/account/presentation/widgets/account_summary_widget.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/expense_total_for_month_widget.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/total_balance_widget.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';
import 'package:thrifter/main.dart';

class ExpenseTotalWidget extends StatelessWidget {
  const ExpenseTotalWidget({
    super.key,
    required this.expenses,
  });

  final List<TransactionEntity> expenses;

  @override
  Widget build(BuildContext context) {
    final double totalExpenseBalance = expenses.fullTotal;
    final double totalExpenses = expenses.totalExpense;
    final double totalIncome = expenses.totalIncome;
    final double totalAccountBalance =
        getIt<Box<AccountModel>>().totalAccountInitialAmount;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: PaisaCard(
            elevation: 0,
            color: context.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TotalBalanceWidget(
                    title: context.loc.totalBalance,
                    amount: totalExpenseBalance + totalAccountBalance,
                  ),
                  const SizedBox(height: 32),
                  ExpenseTotalForMonthWidget(
                    outcome: totalExpenses,
                    income: totalIncome,
                  ),
                ],
              ),
            ),
          ),
        ),
        AccountSummaryWidget(expenses: expenses),
      ],
    );
  }
}
