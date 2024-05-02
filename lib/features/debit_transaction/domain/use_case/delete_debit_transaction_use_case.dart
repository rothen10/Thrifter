// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/debit_transaction/domain/repository/debit_transaction_repository.dart';

part 'delete_debit_transaction_use_case.freezed.dart';

@lazySingleton
class DeleteDebitTransactionUseCase
    implements UseCase<void, DeleteDebitTransactionParams> {
  DeleteDebitTransactionUseCase({required this.debtRepository});

  final DebitTransactionRepository debtRepository;

  @override
  Future<void> call(DeleteDebitTransactionParams params) {
    return debtRepository.deleteDebitTransactionFromId(
      params.debitTransactionId,
    );
  }
}

@freezed
class DeleteDebitTransactionParams with _$DeleteDebitTransactionParams {
  const factory DeleteDebitTransactionParams(int debitTransactionId) =
      _DeleteDebitTransactionParams;
}
