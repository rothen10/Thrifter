// Package imports:
import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/constants/constants.dart';

// Project imports:
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';

extension AccountModelMapping on AccountModel {
  double get initialAmount => amount ?? 0;
  AccountEntity toEntity() => AccountEntity(
        amount: amount,
        bankName: bankName,
        cardType: cardType,
        name: name,
        superId: superId,
        color: color ?? 0xFFFFFFFF,
      );
}

extension AccountModelsMapping on Iterable<AccountModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  List<AccountEntity> toEntities() =>
      map((accountModel) => accountModel.toEntity()).toList();
}

extension AccountBoxMapping on Box<AccountModel> {
  List<AccountEntity> toEntities() => values
      .map((accountModel) => accountModel.toEntity())
      .sorted((a, b) => b.name.compareTo(a.name))
      .toList();

  double get totalAccountInitialAmount {
    final List<int> accounts = settings.get(
      excludedAccountIdKey,
      defaultValue: <int>[],
    );
    return values
        .where((element) => !accounts.contains(element.superId))
        .map((account) => account.initialAmount)
        .fold<double>(0, (previousValue, element) => previousValue + element);
  }
}

extension AccountEntityHelper on AccountEntity {
  double get initialAmount => amount ?? 0;
}
