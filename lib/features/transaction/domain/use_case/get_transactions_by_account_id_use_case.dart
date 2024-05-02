// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';
import 'package:thrifter/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class GetTransactionsByAccountIdUseCase
    implements
        UseCase<List<TransactionEntity>, GetTransactionsByAccountIdParams> {
  GetTransactionsByAccountIdUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;

  @override
  List<TransactionEntity> call(GetTransactionsByAccountIdParams params) =>
      expenseRepository.fetchExpensesFromAccountId(params.accountId);
}

class GetTransactionsByAccountIdParams {
  GetTransactionsByAccountIdParams(this.accountId);

  final int accountId;
}
