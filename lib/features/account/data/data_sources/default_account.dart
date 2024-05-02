// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';

List<AccountModel> defaultAccountsData() {
  return [
    AccountModel(
      name: 'User name',
      bankName: 'Cash',
      cardType: CardType.cash,
      amount: 0.0,
      color: Colors.primaries[0].value,
    ),
    AccountModel(
      name: 'User name',
      bankName: 'Bank',
      amount: 0.0,
      color: Colors.primaries[1].value,
    ),
    AccountModel(
      name: 'User name',
      bankName: 'Wallet',
      cardType: CardType.wallet,
      amount: 0.0,
      color: Colors.primaries[2].value,
    ),
  ];
}
