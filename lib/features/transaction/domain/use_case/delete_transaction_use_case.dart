// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class DeleteTransactionUseCase
    implements UseCase<void, DeleteTransactionParams> {
  DeleteTransactionUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;

  @override
  Future<void> call(DeleteTransactionParams params) async =>
      expenseRepository.clearExpense(params.transactionId);
}

class DeleteTransactionParams {
  DeleteTransactionParams(this.transactionId);

  final int transactionId;
}
