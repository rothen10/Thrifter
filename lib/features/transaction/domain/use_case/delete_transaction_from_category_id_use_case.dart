// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class DeleteTransactionsByCategoryIdUseCase
    implements UseCase<void, DeleteTransactionsByCategoryIdParams> {
  DeleteTransactionsByCategoryIdUseCase({
    required this.transactionRepository,
  });

  final TransactionRepository transactionRepository;

  @override
  Future<void> call(DeleteTransactionsByCategoryIdParams params) =>
      transactionRepository.deleteExpensesByCategoryId(params.categoryId);
}

class DeleteTransactionsByCategoryIdParams {
  DeleteTransactionsByCategoryIdParams(this.categoryId);

  final int categoryId;
}
