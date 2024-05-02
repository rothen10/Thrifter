// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/account/data/model/account_model.dart';
import 'package:thrifter/features/account/domain/entities/account_entity.dart';
import 'package:thrifter/main.dart';

class PillsAccountWidget extends StatefulWidget {
  const PillsAccountWidget({
    super.key,
    required this.accountSelected,
  });

  final Function(AccountEntity) accountSelected;

  @override
  State<PillsAccountWidget> createState() => _PillsAccountWidgetState();
}

class _PillsAccountWidgetState extends State<PillsAccountWidget> {
  late int selectedAccount = -1;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<AccountModel>>(
      valueListenable: getIt<Box<AccountModel>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toEntities();

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 16 / 5,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: accounts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final AccountEntity account = accounts[index];
            return PaisaFilterChip(
              color: Color(account.color),
              onPressed: () {
                setState(() {
                  if (selectedAccount == account.superId) {
                    selectedAccount = -1;
                  } else {
                    selectedAccount = account.superId ?? -1;
                  }
                  widget.accountSelected(account);
                });
              },
              isSelected: account.superId == selectedAccount,
              icon: account.cardType.icon,
              title: account.bankName,
            );
          },
        );
      },
    );
  }
}

class PaisaFilterChip extends StatelessWidget {
  const PaisaFilterChip({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PaisaFilledCard(
      color: color.withOpacity(0.09),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(50),
                )
              : BoxDecoration(
                  border: Border.all(
                    color: color.withOpacity(0.09),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(icon, color: color),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall?.copyWith(color: color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
