// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/category/domain/entities/category.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget({
    super.key,
    required this.expense,
    required this.account,
    required this.category,
  });

  final AccountEntity account;
  final CategoryEntity category;
  final TransactionEntity expense;

  String getSubtitle(BuildContext context) {
    if (expense.type == TransactionType.transfer) {
      return expense.time.shortDayString;
    } else {
      return context.loc.transactionSubTittleText(
        account.bankName,
        expense.time.shortDayString,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        TransactionPageData(transactionId: expense.superId).push(context);
      },
      child: ListTile(
        title: Text(
          expense.name,
          style: context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          getSubtitle(context),
          style: context.bodySmall
              ?.copyWith(color: context.bodySmall?.color?.withOpacity(0.55)),
        ),
        leading: CircleAvatar(
          backgroundColor: Color(category.color).withOpacity(0.2),
          child: Icon(
            IconData(
              category.icon,
              fontFamily: fontFamilyName,
              fontPackage: fontFamilyPackageName,
            ),
            color: Color(category.color),
          ),
        ),
        trailing: Text(
          expense.currency.toFormateCurrency(context),
          style: context.bodyMedium?.copyWith(
            color: expense.type.color(context),
          ),
        ),
      ),
    );
  }
}

class ExpenseTransferItemWidget extends StatelessWidget {
  const ExpenseTransferItemWidget({
    super.key,
    required this.expense,
    required this.fromAccount,
    required this.toAccount,
  });

  final TransactionEntity expense;
  final AccountEntity fromAccount, toAccount;

  String get title {
    return 'Transfer from ${fromAccount.bankName} to ${toAccount.bankName}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          TransactionPageData(transactionId: expense.superId).push(context);
        },
        child: ListTile(
          title: Text(title),
          subtitle: Text(expense.time.shortDayString),
          leading: CircleAvatar(
            backgroundColor: context.primary.withOpacity(0.2),
            child: Icon(
              MdiIcons.bankTransfer,
              color: context.primary,
            ),
          ),
          trailing: Text(
            '${expense.type.sign}${expense.currency.toFormateCurrency(context)}',
            style: context.bodyLarge?.copyWith(
              color: expense.type.color(context),
            ),
          ),
        ),
      ),
    );
  }
}
