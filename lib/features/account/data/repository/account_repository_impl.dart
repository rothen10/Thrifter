// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/features/account/data/data_sources/account_data_source.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/account/domain/repository/account_repository.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountDataSource dataSource;

  @override
  Future<int> add({
    required String bankName,
    required String holderName,
    required CardType cardType,
    double? amount,
    int? color,
    bool? isAccountExcluded,
  }) {
    return dataSource.add(AccountModel(
      name: holderName,
      bankName: bankName,
      cardType: cardType,
      amount: amount,
      color: color,
      isAccountExcluded: isAccountExcluded,
    ));
  }

  @override
  List<AccountEntity> all() {
    return dataSource.accounts().toEntities();
  }

  @override
  Future<void> clearAll() {
    return dataSource.clear();
  }

  @override
  Future<void> delete(int key) {
    return dataSource.delete(key);
  }

  @override
  AccountEntity? fetchById(int? accountId) {
    return dataSource.findById(accountId)?.toEntity();
  }

  @override
  Future<void> update({
    required int key,
    required String bankName,
    required String holderName,
    required CardType cardType,
    double? amount,
    int? color,
    bool? isAccountExcluded,
  }) {
    return dataSource.update(
      AccountModel(
        name: holderName,
        bankName: bankName,
        cardType: cardType,
        amount: amount,
        color: color,
        isAccountExcluded: isAccountExcluded,
        superId: key,
      ),
    );
  }
}
