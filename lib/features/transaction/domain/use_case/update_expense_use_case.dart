// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/enum/transaction_type.dart';
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/transaction/domain/repository/transaction_repository.dart';

part 'update_expense_use_case.freezed.dart';

@lazySingleton
class UpdateTransactionUseCase
    implements UseCase<void, UpdateTransactionParams> {
  UpdateTransactionUseCase({required this.expenseRepository});

  final TransactionRepository expenseRepository;

  @override
  Future<void> call(UpdateTransactionParams params) {
    return expenseRepository.updateExpense(
      key: params.superId,
      name: params.name,
      amount: params.currency,
      time: params.time,
      categoryId: params.categoryId,
      accountId: params.accountId,
      transactionType: params.type,
      description: params.description,
    );
  }
}

@freezed
class UpdateTransactionParams with _$UpdateTransactionParams {
  const factory UpdateTransactionParams({
    required int accountId,
    required int categoryId,
    required double currency,
    required String name,
    required int superId,
    required DateTime time,
    String? description,
    @Default(TransactionType.expense) TransactionType type,
  }) = _UpdateTransactionParams;
}
