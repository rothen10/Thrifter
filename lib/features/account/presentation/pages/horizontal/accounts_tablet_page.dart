// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:thrifter/features/account/presentation/widgets/account_summary_widget.dart';
import 'package:thrifter/features/account/presentation/widgets/account_transaction_widget.dart';
import 'package:thrifter/features/account/presentation/widgets/accounts_page_view_widget.dart';

class AccountsHorizontalTabletPage extends StatelessWidget {
  const AccountsHorizontalTabletPage({
    super.key,
    required this.accounts,
  });

  final List<AccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AccountPageViewWidget(accounts: accounts),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state is AccountSelectedState) {
                    return AccountSummaryWidget(expenses: state.transactions);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
        const Expanded(
          child: AccountTransactionWidget(
            isScroll: true,
          ),
        ),
      ],
    );
  }
}
