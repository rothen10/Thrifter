// Dart imports:
import 'dart:io';

// Package imports:
import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:thrifter/features/account/data/data_sources/account_data_source.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/category/data/data_sources/category_data_source.dart';
import 'package:thrifter/features/category/data/model/category_model.dart';
import 'package:thrifter/features/settings/domain/repository/import_export.dart';
import 'package:thrifter/features/transaction/data/data_sources/local/transaction_data_manager.dart';
import 'package:thrifter/features/transaction/data/model/transaction_model.dart';

@Named('csv')
@LazySingleton(as: Export)
class CSVExport extends Export {
  CSVExport(
    this.deviceInfo,
    this.accountDataManager,
    this.categoryDataManager,
    this.expenseDataManager,
  );

  final AccountDataSource accountDataManager;
  final CategoryDataSource categoryDataManager;
  final DeviceInfoPlugin deviceInfo;
  final TransactionDataSource expenseDataManager;

  @override
  Future<String> export() async {
    final File file = await getTempFile();
    final String csvString = await _fetchAllDataAndEncode();
    await file.writeAsString(csvString);
    return file.path;
  }

  Future<File> getTempFile() async {
    final Directory tempDir = await getTemporaryDirectory();
    return await File('${tempDir.path}/paisa_backup.csv').create();
  }

  Future<String> _fetchAllDataAndEncode() async {
    final List<TransactionModel> expenses =
        expenseDataManager.export().toList();
    final List<List<String>> data = csvDataList(expenses);
    final String csvData = const ListToCsvConverter().convert(data);
    return csvData;
  }

  List<List<String>> csvDataList(List<TransactionModel> expenses) {
    return [
      [
        'No',
        'Expense Name',
        'Amount',
        'Date',
        'Description',
        'Category Name',
        'Category Description',
        'Account Name',
        'Bank Name',
        'Account Type',
      ],
      ...List.generate(
        expenses.length,
        (index) {
          final expense = expenses[index];
          final account = accountDataManager.findById(expense.accountId);
          final category = categoryDataManager.findById(expense.categoryId);
          return expenseRow(
            index,
            expense: expense,
            account: account,
            category: category!,
          );
        },
      ),
    ];
  }

  List<String> expenseRow(
    int index, {
    required TransactionModel expense,
    required AccountModel? account,
    required CategoryModel? category,
  }) {
    return [
      '$index',
      expense.name,
      '${expense.currency}',
      expense.time.toIso8601String(),
      expense.description ?? '',
      category?.name ?? '',
      category?.description ?? '',
      account?.name ?? '',
      account?.bankName ?? '',
      account?.cardType.name ?? 'bank',
    ];
  }
}
