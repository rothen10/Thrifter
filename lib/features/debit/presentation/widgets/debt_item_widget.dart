// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/enum/debt_type.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/debit/data/models/debit_model.dart';
import 'package:thrifter/features/debit/presentation/cubit/debts_bloc.dart';
import 'package:thrifter/features/debit_transaction/data/model/debit_transactions_model.dart';
import 'package:thrifter/features/debit_transaction/domain/entities/debit_transaction_entity.dart';
import 'package:thrifter/main.dart';

class DebtItemWidget extends StatelessWidget {
  const DebtItemWidget({
    super.key,
    required this.debt,
  });

  final DebitModel debt;

  void addPayment(BuildContext context) {
    final controller = TextEditingController();
    DateTime? dateTime;
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth:
            MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                title: Text(
                  context.loc.payDebt,
                  style: context.titleLarge,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PaisaTextFormField(
                        controller: controller,
                        hintText: context.loc.enterAmount,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              try {
                                final text = newValue.text;
                                if (text.isNotEmpty) {
                                  double.parse(text);
                                }
                                return newValue;
                              } catch (_) {}
                              return oldValue;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      onPressed: () async {
                        dateTime = await _showDatePicker(context);
                      },
                      icon: const Icon(Icons.date_range),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    if (dateTime != null) {
                      final double amount =
                          double.tryParse(controller.text) ?? 0;
                      getIt<DebitBloc>().add(
                          AddTransactionToDebtEvent(debt, amount, dateTime!));
                      Navigator.pop(context);
                    } else {
                      context.showMaterialSnackBar(
                          context.loc.selectDateErrorMessage);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    context.loc.update,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    final DateTime? time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<DebitTransactionsModel>>(
      valueListenable: getIt<Box<DebitTransactionsModel>>().listenable(),
      builder: (context, value, child) {
        final List<DebitTransactionEntity> transactions =
            value.getTransactionsFromId(debt.superId ?? 0);
        final double amount = transactions.fold<double>(
            0, (previousValue, element) => previousValue + element.amount);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PaisaFilledCard(
            child: InkWell(
              onTap: () {
                DebitPageData(debtId: debt.superId).push(context);
              },
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      debt.name,
                      style: context.headlineSmall?.copyWith(
                        color: context.onSurfaceVariant,
                      ),
                    ),
                    subtitle: Text(
                      debt.description,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.75),
                      ),
                    ),
                    trailing: Text(
                      (debt.amount - amount).toFormateCurrency(context),
                      style: context.titleLarge?.copyWith(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: amount / debt.amount,
                        backgroundColor: context.secondaryContainer,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '${debt.expiryDateTime.daysDifference.isNegative ? '0' : debt.expiryDateTime.daysDifference}  Days Left',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, right: 14),
                        child: TextButton.icon(
                          icon: Icon(
                            MdiIcons.cashClock,
                            color: context.onSurfaceVariant,
                          ),
                          label: Text(
                            debt.debtType == DebitType.debit
                                ? context.loc.payDebt
                                : context.loc.payCredit,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            addPayment(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
