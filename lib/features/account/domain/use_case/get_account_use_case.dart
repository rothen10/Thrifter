// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/account/domain/repository/account_repository.dart';

part 'get_account_use_case.freezed.dart';

@lazySingleton
class GetAccountUseCase implements UseCase<AccountEntity?, GetAccountParams> {
  GetAccountUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  AccountEntity? call(GetAccountParams params) {
    return accountRepository.fetchById(params.accountId);
  }
}

@freezed
class GetAccountParams with _$GetAccountParams {
  const factory GetAccountParams(int? accountId) = _GetAccountParams;
}
