// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/account/domain/repository/account_repository.dart';

@lazySingleton
class GetAccountsUseCase implements UseCase<List<AccountEntity>, NoParams> {
  GetAccountsUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  List<AccountEntity> call(NoParams? params) {
    return accountRepository.all();
  }
}
