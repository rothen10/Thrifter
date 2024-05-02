// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:thrifter/features/transaction/domain/entities/transaction_entity.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/summary_desktop_widget.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/summary_mobile_widget.dart';
import 'package:thrifter/features/home/presentation/pages/summary/widgets/summary_tablet_widget.dart';
import 'package:thrifter/features/transaction/data/model/transaction_model.dart';
import 'package:thrifter/main.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TransactionModel>>(
      valueListenable: getIt<Box<TransactionModel>>().listenable(),
      builder: (_, value, child) {
        final List<TransactionEntity> transactions =
            value.values.toExcludeAccounts();
        return ScreenTypeLayout.builder(
          mobile: (p0) => SummaryMobileWidget(expenses: transactions),
          tablet: (p0) => SummaryTabletWidget(expenses: transactions),
          desktop: (p0) => SummaryDesktopWidget(expenses: transactions),
        );
      },
    );
  }
}
