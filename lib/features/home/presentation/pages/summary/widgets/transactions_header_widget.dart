// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/features/home/presentation/controller/summary_controller.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/filter_home_expenses_widget.dart';

class TransactionsHeaderWidget extends StatelessWidget {
  const TransactionsHeaderWidget({
    super.key,
    required this.summaryController,
  });

  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      title: Text(
        context.loc.transactions,
        style: context.titleMedium?.copyWith(
          color: context.onBackground,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          foregroundColor: context.primary,
        ),
        label: ValueListenableBuilder<FilterExpense>(
          valueListenable: summaryController.sortHomeExpenseNotifier,
          builder: (context, value, child) {
            return Text(value.stringValue(context));
          },
        ),
        icon: Icon(MdiIcons.sortVariant),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width >= 700
                  ? 700
                  : double.infinity,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            builder: (context) {
              return FilterHomeExpensesWidget(
                  summaryController: summaryController);
            },
          );
        },
      ),
    );
  }
}
