// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/account/presentation/widgets/account_transaction_widget.dart';
import 'package:thrifter/features/account/presentation/widgets/accounts_page_view_widget.dart';

class AccountsHorizontalMobilePage extends StatelessWidget {
  const AccountsHorizontalMobilePage({super.key, required this.accounts});

  final List<AccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      key: const Key('accounts_list_view'),
      padding: const EdgeInsets.only(bottom: 124),
      children: [
        AccountPageViewWidget(accounts: accounts),
        const AccountTransactionWidget()
      ],
    );
  }
}
