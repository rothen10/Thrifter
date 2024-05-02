// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';
import 'package:thrifter/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class GetTransactionUseCase
    implements UseCase<Future<TransactionEntity?>, GetTransactionParams> {
  GetTransactionUseCase({required this.transactionRepository});

  final TransactionRepository transactionRepository;

  @override
  Future<TransactionEntity?> call(GetTransactionParams params) async =>
      transactionRepository.fetchExpenseFromId(params.transactionId);
}

class GetTransactionParams {
  GetTransactionParams(this.transactionId);

  final int transactionId;
}
