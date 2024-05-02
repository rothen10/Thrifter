// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/recurring/data/model/recurring.dart';
import 'package:thrifter/main.dart';

class RecurringPage extends StatelessWidget {
  const RecurringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        body: ValueListenableBuilder<Box<RecurringModel>>(
          valueListenable: getIt<Box<RecurringModel>>().listenable(),
          builder: (_, value, child) {
            final List<RecurringModel> recurringModels = value.values.toList();
            if (recurringModels.isEmpty) {
              return EmptyWidget(
                title: context.loc.recurringEmptyMessageTitle,
                description: context.loc.recurringEmptyMessageSubTitle,
                icon: MdiIcons.cashSync,
                actionTitle: context.loc.recurringAction,
                onActionPressed: () {
                  const AddRecurringPageData().push(context);
                },
              );
            }
            return RecurringListWidget(recurringModels: recurringModels);
          },
        ),
      ),
    );
  }
}

class RecurringListWidget extends StatelessWidget {
  const RecurringListWidget({super.key, required this.recurringModels});

  final List<RecurringModel> recurringModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: recurringModels.length,
      itemBuilder: (context, index) {
        final RecurringModel expense = recurringModels[index];
        final String subtitle =
            '${expense.recurringType.name(context)} - ${expense.recurringDate.shortDayString}';
        return ListTile(
          title: Text(expense.name),
          subtitle: Text(subtitle),
          trailing: IconButton(
            onPressed: () async {
              await expense.delete();
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
