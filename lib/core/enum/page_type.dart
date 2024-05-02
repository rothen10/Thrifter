// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:thrifter/core/common.dart';

enum PageType {
  home,
  accounts,
  category,
  overview,
  debts,
  budget,
  recurring,
  goals;

  int get toIndex {
    switch (this) {
      case PageType.home:
        return 0;
      case PageType.accounts:
        return 1;
      case PageType.category:
        return 2;
      case PageType.overview:
        return 3;
      case PageType.debts:
        return 4;
      case PageType.budget:
        return 5;
      case PageType.recurring:
        return 6;
      case PageType.goals:
        return 7;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case PageType.home:
        return context.loc.home;
      case PageType.accounts:
        return context.loc.accounts;
      case PageType.overview:
        return context.loc.overview;
      case PageType.category:
        return context.loc.categories;
      case PageType.debts:
        return context.loc.debts;
      case PageType.budget:
        return context.loc.budget;
      case PageType.recurring:
        return context.loc.recurring;
      case PageType.goals:
        return context.loc.goals;
    }
  }

  String toolTip(BuildContext context) {
    switch (this) {
      case PageType.home:
        return context.loc.addTransactionTooltip;
      case PageType.accounts:
        return context.loc.addAccountTooltip;
      case PageType.overview:
        return context.loc.selectDateRangeTooltip;
      case PageType.category:
        return context.loc.addCategoryTooltip;
      case PageType.debts:
        return context.loc.addDebtTooltip;
      case PageType.recurring:
        return context.loc.recurring;
      case PageType.budget: // Doesn't have FAB button
        return '';
      case PageType.goals:
        return context.loc.addGoalTooltip;
    }
  }
}
