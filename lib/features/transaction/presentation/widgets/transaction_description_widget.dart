// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/transaction/presentation/bloc/transaction_bloc.dart';

class TransactionDescriptionWidget extends StatelessWidget {
  const TransactionDescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
        controller: controller,
        hintText: context.loc.description,
        keyboardType: TextInputType.name,
        onChanged: (value) =>
            context.read<TransactionBloc>().currentDescription = value,
      ),
    );
  }
}
