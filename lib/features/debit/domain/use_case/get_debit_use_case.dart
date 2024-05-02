// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/debit/domain/entities/debit.dart';
import 'package:thrifter/features/debit/domain/repository/debit_repository.dart';

part 'get_debit_use_case.freezed.dart';

@lazySingleton
class GetDebitUseCase implements UseCase<DebitEntity?, GetDebitParams> {
  GetDebitUseCase({required this.debtRepository});

  final DebitRepository debtRepository;

  @override
  DebitEntity? call(GetDebitParams params) {
    return debtRepository.fetchDebtOrCreditFromId(params.debitId);
  }
}

@freezed
class GetDebitParams with _$GetDebitParams {
  const factory GetDebitParams(int debitId) = _GetDebitParams;
}
