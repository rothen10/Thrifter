// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/enum/debt_type.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/debit/data/models/debit_model.dart';
import 'package:thrifter/features/debit/presentation/widgets/debt_list_widget.dart';
import 'package:thrifter/main.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(32),
                color: context.surfaceVariant,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  splashBorderRadius: BorderRadius.circular(32),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: context.primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: context.onPrimary,
                  unselectedLabelColor: context.onSurfaceVariant,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: context.loc.debt),
                    Tab(text: context.loc.credit),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<DebitModel>>(
          valueListenable: getIt<Box<DebitModel>>().listenable(),
          builder: (context, value, child) {
            final debts = value.values
                .where((element) => element.debtType == DebitType.debit)
                .toList();

            final credits = value.values
                .where((element) => element.debtType == DebitType.credit)
                .toList();

            return TabBarView(
              children: [
                Builder(
                  builder: (context) {
                    return debts.isNotEmpty
                        ? DebtsListWidget(debts: debts)
                        : EmptyWidget(
                            title: context.loc.emptyDebts,
                            icon: MdiIcons.cashMinus,
                            description: context.loc.emptyDebtsDesc,
                          );
                  },
                ),
                Builder(
                  builder: (context) {
                    return credits.isNotEmpty
                        ? DebtsListWidget(debts: credits)
                        : EmptyWidget(
                            title: context.loc.emptyCredit,
                            icon: MdiIcons.cashMinus,
                            description: context.loc.emptyCreditDesc,
                          );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
