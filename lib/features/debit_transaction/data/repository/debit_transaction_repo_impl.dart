// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/debit_transaction/data/data_source/debit_transactions_data_store.dart';
import 'package:thrifter/features/debit_transaction/data/model/debit_transactions_model.dart';
import 'package:thrifter/features/debit_transaction/domain/entities/debit_transaction_entity.dart';
import 'package:thrifter/features/debit_transaction/domain/repository/debit_transaction_repository.dart';

@LazySingleton(as: DebitTransactionRepository)
class DebitTransactionRepoImpl implements DebitTransactionRepository {
  DebitTransactionRepoImpl({required this.dataStore});

  final DebtTransactionDataSource dataStore;

  @override
  Future<void> addTransaction(
    double amount,
    DateTime currentDateTime,
    int parentId,
  ) {
    return dataStore.addTransaction(DebitTransactionsModel(
      amount: amount,
      now: currentDateTime,
      parentId: parentId,
    ));
  }

  @override
  Future<void> deleteDebitTransactionFromId(int transactionId) {
    return dataStore.deleteDebitTransactionFromId(transactionId);
  }

  @override
  Future<void> deleteDebitTransactionsFromDebitId(int parentId) {
    return dataStore.deleteDebitTransactionsFromDebitId(parentId);
  }

  @override
  List<DebitTransactionEntity> fetchTransactionsFromId(int id) {
    return dataStore.getTransactionsFromId(id).toEntities();
  }
}
