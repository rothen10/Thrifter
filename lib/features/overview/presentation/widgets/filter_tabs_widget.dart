// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/enum/filter_expense.dart';
import 'package:thrifter/core/enum/transaction_type.dart';
import 'package:thrifter/core/widgets/paisa_widgets/paisa_pill_chip.dart';
import 'package:thrifter/features/home/presentation/controller/summary_controller.dart';
import 'package:thrifter/main.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key, required this.valueNotifier});

  final ValueNotifier<FilterExpense> valueNotifier;

  @override
  Widget build(BuildContext context) {
    final filters = [
      FilterExpense.daily,
      FilterExpense.weekly,
      FilterExpense.monthly,
      FilterExpense.yearly,
      FilterExpense.all,
    ];
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: valueNotifier,
      builder: (context, snapshot, child) {
        return SelectionTabWidget(
          tabs: filters.map((e) => e.stringValue(context)).toList(),
          onSelected: (value) {
            valueNotifier.value = value.toFilterExpense(context);
          },
          selected: snapshot.stringValue(context),
        );
      },
    );
  }
}

class FilterSecondaryTabsWidget extends StatelessWidget {
  const FilterSecondaryTabsWidget({
    super.key,
    required this.dates,
    required this.valueNotifier,
  });

  final List<String> dates;
  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: valueNotifier,
      builder: (context, snapshot, child) {
        return SelectionTabWidget(
          tabs: dates,
          onSelected: (value) {
            valueNotifier.value = value;
          },
          selected: valueNotifier.value,
        );
      },
    );
  }
}

class CategoryTransactionFilterWidget extends StatelessWidget {
  const CategoryTransactionFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: ValueListenableBuilder<TransactionType>(
        valueListenable: getIt<SummaryController>().typeNotifier,
        builder: (context, type, child) {
          return SegmentedButton<TransactionType>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment<TransactionType>(
                value: TransactionType.income,
                label: Text(context.loc.income),
              ),
              ButtonSegment<TransactionType>(
                value: TransactionType.expense,
                label: Text(context.loc.expense),
              ),
            ],
            selected: <TransactionType>{type},
            onSelectionChanged: (newSelection) {
              getIt<SummaryController>().typeNotifier.value =
                  newSelection.first;
            },
          );
        },
      ),
    );
  }
}

class SelectionTabWidget extends StatelessWidget {
  const SelectionTabWidget({
    super.key,
    required this.tabs,
    required this.onSelected,
    required this.selected,
  });

  final Function(String value) onSelected;
  final String selected;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 4),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final e = tabs[index];
          return PaisaPillChip(
            title: e,
            onPressed: () {
              onSelected(e);
            },
            isSelected: e == selected,
          );
        },
      ),
    );
  }
}
