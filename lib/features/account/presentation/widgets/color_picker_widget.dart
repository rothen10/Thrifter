// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/account/presentation/bloc/accounts_bloc.dart';

class AccountColorPickerWidget extends StatelessWidget {
  const AccountColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      buildWhen: (previous, current) =>
          current is AccountColorSelectedState ||
          current is AccountSuccessState,
      builder: (context, state) {
        int color = Colors.red.value;
        if (state is AccountColorSelectedState) {
          color = state.color;
        }
        if (state is AccountSuccessState) {
          color = state.account.color;
        }
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () async {
            final color = await paisaColorPicker(
              context,
              defaultColor:
                  context.read<AccountBloc>().selectedColor ?? Colors.red.value,
            );
            if (context.mounted) {
              context.read<AccountBloc>().add(AccountColorSelectedEvent(color));
            }
          },
          leading: Icon(
            Icons.color_lens,
            color: context.primary,
          ),
          title: Text(
            context.loc.pickColor,
          ),
          subtitle: Text(
            context.loc.pickColorDesc,
          ),
          trailing: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(color),
            ),
          ),
        );
      },
    );
  }
}
