// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/home/presentation/controller/summary_controller.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/expense_month_card.dart';
import 'package:thrifter/main.dart';

class ExpenseHistoryWidget extends StatelessWidget {
  const ExpenseHistoryWidget({
    super.key,
    required this.expenses,
  });

  final List<TransactionEntity> expenses;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return EmptyWidget(
        title: context.loc.emptyExpensesMessageTitle,
        icon: Icons.money_off_rounded,
        description: context.loc.emptyExpensesMessageSubTitle,
      );
    } else {
      return ValueListenableBuilder<FilterExpense>(
        valueListenable: getIt<SummaryController>().notifyFilterExpense,
        builder: (context, value, child) {
          final Map<String, List<TransactionEntity>> maps =
              groupBy(expenses, (element) => element.time.formatted(value));
          return ListView.separated(
            separatorBuilder: (context, index) => const PaisaDivider(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: maps.entries.length,
            itemBuilder: (_, mapIndex) => ExpenseMonthCardWidget(
              title: maps.keys.elementAt(mapIndex),
              total: maps.values.elementAt(mapIndex).filterTotal,
              expenses: maps.values.elementAt(mapIndex),
            ),
          );
        },
      );
    }
  }
}
