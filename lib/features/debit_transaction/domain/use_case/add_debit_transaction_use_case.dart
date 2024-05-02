// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/debit_transaction/domain/repository/debit_transaction_repository.dart';

part 'add_debit_transaction_use_case.freezed.dart';

@lazySingleton
class AddDebitTransactionUseCase
    implements UseCase<Future<void>, AddDebitTransactionParams> {
  AddDebitTransactionUseCase({required this.debtRepository});

  final DebitTransactionRepository debtRepository;

  @override
  Future<void> call(AddDebitTransactionParams params) {
    return debtRepository.addTransaction(
      params.amount,
      params.currentDateTime,
      params.parentId,
    );
  }
}

@freezed
class AddDebitTransactionParams with _$AddDebitTransactionParams {
  const factory AddDebitTransactionParams({
    required double amount,
    required DateTime currentDateTime,
    required int parentId,
  }) = _AddDebitTransactionParams;
}
