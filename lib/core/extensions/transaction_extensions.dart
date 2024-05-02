// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';

// Project imports:
import 'package:thrifter/core/enum/transaction_type.dart';
import 'package:thrifter/features/transaction/data/model/search_query.dart';
import 'package:thrifter/features/transaction/data/model/transaction_model.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';

extension ExpenseModelBoxMapping on Box<TransactionModel> {
  List<TransactionModel> get expenses =>
      values.sorted((a, b) => b.time.compareTo(a.time));

  List<TransactionModel> expensesFromAccountId(int accountId) =>
      expenses.where((element) => element.accountId == accountId).toList();

  List<TransactionEntity> get toEntities => values
      .map((expenseModel) => expenseModel.toEntity())
      .sorted((a, b) => b.time.compareTo(a.time));

  List<TransactionModel> isFilterTimeBetween(DateTimeRange range) =>
      values.where((element) => element.time.isAfterBeforeTime(range)).toList();

  Iterable<TransactionModel> get expenseList =>
      values.where((element) => element.type == TransactionType.expense);

  Iterable<TransactionModel> get incomeList =>
      values.where((element) => element.type == TransactionType.income);

  double get totalExpense => expenseList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + (element));

  double get totalIncome => incomeList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + (element));

  Iterable<TransactionModel> search(SearchQuery query) {
    return values.where((element) {
      final String text = query.query?.toLowerCase() ?? '';
      final String desc = (element.description ?? '').toLowerCase();
      final String name = element.name.toLowerCase();
      final List<int?> accounts = query.accounts;
      final List<int?> categories = query.categories;
      final bool result = (name.contains(text) || desc.contains(text));
      if (accounts.isNotEmpty || categories.isNotEmpty) {
        return result &&
            (accounts.contains(element.accountId) ||
                categories.contains(element.categoryId));
      }
      return (name.contains(text) || desc.contains(text));
    });
  }
}

extension ExpenseModelHelper on TransactionModel {
  TransactionEntity toEntity() => TransactionEntity(
        name: name,
        currency: currency,
        time: time,
        categoryId: categoryId,
        accountId: accountId,
        type: type,
        description: description,
        superId: superId,
      );
}

extension ExpenseModelsHelper on Iterable<TransactionModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  List<TransactionEntity> toExcludeAccounts() {
    final accounts = settings.get(
      excludedAccountIdKey,
      defaultValue: <int>[],
    );
    return map((expenseModel) => expenseModel.toEntity())
        .where((element) => !accounts.contains(element.accountId))
        .sorted((a, b) => b.time.compareTo(a.time));
  }

  List<TransactionEntity> toEntities() {
    return map((expenseModel) => expenseModel.toEntity())
        .sorted((a, b) => b.time.compareTo(a.time));
  }
}

extension ExpensesHelper on Iterable<TransactionEntity> {
  List<TransactionEntity> budgetOverView(TransactionType transactionType) =>
      sorted((a, b) => b.time.compareTo(a.time))
          .where((element) => element.type == transactionType)
          .toList();
  List<TransactionEntity> sortByTime() =>
      sorted((a, b) => b.time.compareTo(a.time));

  List<TransactionEntity> get expenses => sortByTime();

  List<TransactionEntity> get expenseList =>
      where((element) => element.type == TransactionType.expense).toList();

  List<TransactionEntity> get incomeList =>
      where((element) => element.type == TransactionType.income).toList();

  List<TransactionEntity> isFilterTimeBetween(DateTimeRange range) =>
      where((element) => element.time.isAfterBeforeTime(range)).toList();

  double get filterTotal => fold<double>(0, (previousValue, element) {
        if (element.type == TransactionType.expense) {
          return previousValue - (element.currency);
        } else if (element.type == TransactionType.income) {
          return previousValue + (element.currency);
        } else {
          return previousValue;
        }
      });
  double get fullTotal => totalIncome - totalExpense;

  double get totalExpense => expenseList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + (element));

  double get totalIncome => incomeList
      .map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + (element));

  double get total => map((e) => e.currency)
      .fold<double>(0, (previousValue, element) => previousValue + (element));

  double get thisMonthExpense =>
      where((element) => element.type == TransactionType.expense)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .map((e) => e.currency)
          .fold<double>(
              0, (previousValue, element) => previousValue + (element));

  List<TransactionEntity> get thisMonthExpensesList =>
      where((element) => element.type == TransactionType.expense)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .toList();

  List<double> get expenseDoubleList =>
      thisMonthExpensesList.map((element) => (element.currency)).toList();

  List<TransactionEntity> get thisMonthIncomeList =>
      where((element) => element.type == TransactionType.income)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .toList();

  List<double> get incomeDoubleList =>
      thisMonthIncomeList.map((element) => (element.currency)).toList();

  double get thisMonthIncome =>
      where((element) => element.type == TransactionType.income)
          .where((element) =>
              element.time.month == DateTime.now().month &&
              element.time.year == DateTime.now().year)
          .map((e) => e.currency)
          .fold<double>(
              0, (previousValue, element) => previousValue + (element));
}

extension TransactionHelper on TransactionEntity {}

extension TransactionModelsHelper on List<TransactionModel> {
  double get totalIncome =>
      where((element) => element.type == TransactionType.income)
          .map((e) => e.currency)
          .fold<double>(
              0, (previousValue, element) => previousValue + (element));
  double get totalExpense =>
      where((element) => element.type == TransactionType.expense)
          .map((e) => e.currency)
          .fold<double>(
              0, (previousValue, element) => previousValue + (element));
}
