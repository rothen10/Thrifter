// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/debit/presentation/cubit/debts_bloc.dart';
import 'package:thrifter/features/debit/presentation/widgets/debt_toggle_buttons_widget.dart';
import 'package:thrifter/features/debit_transaction/data/model/debit_transactions_model.dart';
import 'package:thrifter/features/debit_transaction/domain/entities/debit_transaction_entity.dart';
import 'package:thrifter/main.dart';

class DebitPage extends StatefulWidget {
  const DebitPage({
    super.key,
    this.debtId,
  });

  final int? debtId;

  @override
  State<DebitPage> createState() => _DebitPageState();
}

class _DebitPageState extends State<DebitPage> {
  final TextEditingController amountController = TextEditingController();
  final DebitBloc debitBloc = getIt<DebitBloc>();
  final TextEditingController descController = TextEditingController();
  late final bool isDebtAddOrUpdate = widget.debtId == null;
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    debitBloc.add(FetchDebtOrCreditFromIdEvent(widget.debtId));
  }

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: BlocProvider(
        create: (_) => debitBloc,
        child: BlocConsumer(
          bloc: debitBloc,
          listener: (context, state) {
            if (state is DebtsAdded) {
              GoRouter.of(context).pop();
            } else if (state is DebtsSuccessState) {
              amountController.text = state.debt.amount.toString();
              amountController.selection = TextSelection.collapsed(
                offset: state.debt.amount.toString().length,
              );

              nameController.text = state.debt.name.toString();
              nameController.selection = TextSelection.collapsed(
                offset: state.debt.name.toString().length,
              );

              descController.text = state.debt.description.toString();
              descController.selection = TextSelection.collapsed(
                offset: state.debt.description.toString().length,
              );
            } else if (state is DebtErrorState) {
              context.showMaterialSnackBar(
                state.errorString,
                backgroundColor: context.errorContainer,
                color: context.onErrorContainer,
              );
            } else if (state is DeleteDebtsState) {
              context.pop();
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: context.materialYouAppBar(
                context.loc.addDebt,
                actions: [
                  if (isDebtAddOrUpdate)
                    const SizedBox.shrink()
                  else
                    IconButton(
                      onPressed: () => paisaAlertDialog(
                        context,
                        title: Text(context.loc.dialogDeleteTitle),
                        child: RichText(
                          text: TextSpan(
                            text: context.loc.deleteDebtOrCredit,
                            style: context.bodyLarge,
                          ),
                        ),
                        confirmationButton: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            debitBloc.add(DeleteDebtEvent(widget.debtId!));
                          },
                          child: const Text('Delete'),
                        ),
                      ).then((value) => context.pop()),
                      icon: Icon(
                        Icons.delete_rounded,
                        color: context.error,
                      ),
                    )
                ],
              ),
              body: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const DebtToggleButtonsWidget(),
                    const SizedBox(height: 16),
                    AmountWidget(controller: amountController),
                    const SizedBox(height: 16),
                    NameWidget(controller: nameController),
                    const SizedBox(height: 16),
                    DescriptionWidget(controller: descController),
                    const SizedBox(height: 16),
                    const StartAndEndDateWidget(),
                    ListTile(
                      title: Text(
                        context.loc.transactionHistory,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ValueListenableBuilder<Box<DebitTransactionsModel>>(
                      valueListenable:
                          getIt<Box<DebitTransactionsModel>>().listenable(),
                      builder: (context, value, child) {
                        final int? parentId = widget.debtId;
                        if (parentId == null) return const SizedBox.shrink();
                        final List<DebitTransactionEntity> transactions =
                            value.getTransactionsFromId(parentId);

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (_, index) {
                            final DebitTransactionEntity transaction =
                                transactions[index];
                            return ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  debitBloc.add(
                                    DeleteTransactionEvent(
                                        transaction.superId!),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              title: Text(transaction.now.formattedDate),
                              trailing: Text(transaction.amount
                                  .toFormateCurrency(context)),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PaisaBigButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      debitBloc.add(AddOrUpdateEvent(isDebtAddOrUpdate));
                    },
                    title: isDebtAddOrUpdate
                        ? context.loc.add
                        : context.loc.update,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StartAndEndDateWidget extends StatelessWidget {
  const StartAndEndDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<DebitBloc, DebtsState>(
            buildWhen: (previous, current) => current is SelectedStartDateState,
            builder: (context, state) {
              if (state is SelectedStartDateState) {
                return DatePickerWidget(
                  onSelected: (date) {
                    context.read<DebitBloc>().add(SelectedStartDateEvent(date));
                  },
                  title: context.loc.startDate,
                  subtitle: state.startDateTime.formattedDate,
                  icon: MdiIcons.calendarStart,
                  lastDate: DateTime.now(),
                  firstDate: DateTime(2000),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<DebitBloc, DebtsState>(
            buildWhen: (previous, current) => current is SelectedEndDateState,
            builder: (context, state) {
              if (state is SelectedEndDateState) {
                return DatePickerWidget(
                  onSelected: (date) {
                    context.read<DebitBloc>().add(SelectedEndDateEvent(date));
                  },
                  title: context.loc.dueDate,
                  subtitle: state.endDateTime.formattedDate,
                  icon: MdiIcons.calendarEnd,
                  lastDate: DateTime(2050),
                  firstDate: DateTime.now(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    required this.onSelected,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.lastDate,
    required this.firstDate,
  });

  final DateTime firstDate;
  final IconData icon;
  final DateTime lastDate;
  final Function(DateTime) onSelected;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () async {
        final result = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (result == null) return;
        onSelected.call(result);
      },
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        hintText: context.loc.nameHint,
        validator: (value) {
          if (value!.length >= 2) {
            return null;
          } else {
            return context.loc.validName;
          }
        },
        onChanged: (value) => context.read<DebitBloc>().currentName = value,
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        hintText: context.loc.description,
        validator: (value) {
          if (value!.length >= 3) {
            return null;
          } else {
            return context.loc.validDescription;
          }
        },
        onChanged: (value) =>
            context.read<DebitBloc>().currentDescription = value,
      ),
    );
  }
}

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        hintText: context.loc.amount,
        onChanged: (value) {
          double? amount = double.tryParse(value);
          context.read<DebitBloc>().currentAmount = amount;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            try {
              final text = newValue.text;
              if (text.isNotEmpty) double.parse(text);
              return newValue;
            } catch (_) {}
            return oldValue;
          }),
        ],
        validator: (value) {
          if (value!.isNotEmpty) {
            return null;
          } else {
            return context.loc.validAmount;
          }
        },
      ),
    );
  }
}
