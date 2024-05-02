// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/core/widgets/paisa_widgets/paisa_divider.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/home/presentation/controller/summary_controller.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/expense_month_card.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';

class AccountHistoryWidget extends StatelessWidget {
  const AccountHistoryWidget({
    super.key,
    required this.expenses,
    required this.summaryController,
  });

  final List<TransactionEntity> expenses;
  final SummaryController summaryController;

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
        valueListenable: summaryController.sortHomeExpenseNotifier,
        builder: (_, value, __) {
          final Map<String, List<TransactionEntity>> maps = groupBy(expenses,
              (TransactionEntity element) => element.time.formatted(value));
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
