// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/debit/data/models/debit_model.dart';
import 'package:thrifter/features/debit_transaction/data/model/debit_transactions_model.dart';
import 'package:thrifter/features/goals/data/models/goal_model.dart';
import 'package:thrifter/features/intro/data/models/country_model.dart';
import 'package:thrifter/features/recurring/data/model/recurring.dart';
import 'package:thrifter/features/transaction/data/model/transaction_model.dart';

@module
abstract class HiveBoxModule {
  @lazySingleton
  @preResolve
  Future<Box<TransactionModel>> get expenseBox =>
      Hive.openBox<TransactionModel>(BoxType.expense.name);

  @lazySingleton
  @preResolve
  Future<Box<AccountModel>> get accountBox =>
      Hive.openBox<AccountModel>(BoxType.accounts.name);

  @lazySingleton
  @preResolve
  Future<Box<CategoryModel>> get categoryBox =>
      Hive.openBox<CategoryModel>(BoxType.category.name);

  @lazySingleton
  @preResolve
  Future<Box<DebitModel>> get debtsBox =>
      Hive.openBox<DebitModel>(BoxType.debts.name);

  @lazySingleton
  @preResolve
  Future<Box<DebitTransactionsModel>> get transactionsBox =>
      Hive.openBox<DebitTransactionsModel>(BoxType.transactions.name);

 

  @lazySingleton
  @preResolve
  Future<Box<GoalModel>> get goalBox =>
      Hive.openBox<GoalModel>(BoxType.recurring.name);

  @lazySingleton
  @preResolve
  @Named('settings')
  Future<Box<dynamic>> get boxDynamic =>
      Hive.openBox<dynamic>(BoxType.settings.name);
}

class HiveAdapters {
  Future<void> initHive() async {
    await Hive.initFlutter(hivePath);
    Hive
      ..registerAdapter(TransactionModelAdapter())
      ..registerAdapter(CategoryModelAdapter())
      ..registerAdapter(CountryModelAdapter())
      ..registerAdapter(AccountModelAdapter())
      ..registerAdapter(TransactionTypeAdapter())
      ..registerAdapter(DebitModelAdapter())
      ..registerAdapter(DebitTypeAdapter())
      ..registerAdapter(DebitTransactionsModelAdapter())
      ..registerAdapter(CardTypeAdapter())
      ..registerAdapter(RecurringTypeAdapter())
      ..registerAdapter(RecurringModelAdapter())
      ..registerAdapter(GoalModelAdapter())
      ..registerAdapter(FilterExpenseAdapter());
  }

  String? get hivePath {
    if (kIsWeb) {
      return 'paisa';
    } else if (TargetPlatform.windows == defaultTargetPlatform) {
      return 'paisa';
    } else {
      return null;
    }
  }
}
