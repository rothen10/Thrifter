// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:thrifter/app.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/di/dependency_injection.dart';
import 'package:thrifter/features/account/data/data_sources/account_data_source.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/category/data/data_sources/category_data_source.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/transaction/data/data_sources/local/transaction_data_manager.dart';
import 'package:thrifter/features/transaction/data/model/transaction_model.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt);
  runApp(const ThrifterApp());
  if (TargetPlatform.android == defaultTargetPlatform ||
      TargetPlatform.iOS == defaultTargetPlatform) {
    initAppShortcuts();
  }
}

_addDummyData() async {
  final accountDataSource = getIt<AccountDataSource>();
  final categoryDataSource = getIt<CategoryDataSource>();
  final transactionDataSource = getIt<TransactionDataSource>();

  await accountDataSource.clear();
  await categoryDataSource.clear();
  await transactionDataSource.clear();

  for (int i = 0; i < 10; i++) {
    await accountDataSource.add(
      AccountModel(
        bankName: 'Bank Name $i',
        name: 'Holder name $i',
        cardType: CardType.values[Random().nextInt(3)],
        color: Colors.amber.value,
      ),
    );

    await categoryDataSource.add(
      CategoryModel(
        name: 'Category name $i',
        color: Colors.amber.value,
        icon: Icons.car_crash.codePoint,
      ),
    );
  }
  final random = Random();
  final startDate = DateTime(2010);
  final endDate = DateTime.now();

  for (int i = 0; i < 100; i++) {
    int accountId = Random().nextInt(10);
    int categoryId = Random().nextInt(10);
    final difference = endDate.difference(startDate).inDays;
    final randomDay = random.nextInt(difference);
    final randomDate = startDate.add(Duration(days: randomDay));
    await transactionDataSource.add(TransactionModel(
      name: 'Transaction name $i',
      time: randomDate,
      accountId: accountId,
      categoryId: categoryId,
      currency: Random().nextDouble() * 100000,
      type: TransactionType.values[Random().nextInt(2)],
    ));
  }
}
