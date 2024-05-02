// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrifter/features/home/presentation/controller/summary_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Project imports:
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/home/presentation/pages/home/home_cubit.dart';
import 'package:thrifter/features/home/presentation/widgets/home_desktop_widget.dart';
import 'package:thrifter/features/home/presentation/widgets/home_mobile_widget.dart';
import 'package:thrifter/features/home/presentation/widgets/home_tablet_widget.dart';
import 'package:thrifter/features/home/presentation/widgets/variable_size_fab.dart';
import 'package:thrifter/main.dart';

final destinations = [
  Destination(
    pageType: PageType.home,
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home_rounded),
  ),
  Destination(
    pageType: PageType.accounts,
    icon: const Icon(Icons.credit_card_outlined),
    selectedIcon: const Icon(Icons.credit_card),
  ),
  Destination(
    pageType: PageType.debts,
    icon: Icon(MdiIcons.accountCashOutline),
    selectedIcon: Icon(MdiIcons.accountCash),
  ),
  Destination(
    pageType: PageType.overview,
    icon: Icon(MdiIcons.sortVariant),
    selectedIcon: Icon(MdiIcons.sortVariant),
  ),
  Destination(
    pageType: PageType.category,
    icon: const Icon(Icons.category_outlined),
    selectedIcon: const Icon(Icons.category),
  ),
  Destination(
    pageType: PageType.budget,
    icon: Icon(MdiIcons.timetable),
    selectedIcon: Icon(MdiIcons.timetable),
  ),
  Destination(
    pageType: PageType.recurring,
    icon: Icon(MdiIcons.cashSync),
    selectedIcon: Icon(MdiIcons.cashSync),
  ),
  /*  Destination(
    pageType: PageType.goals,
    icon: Icon(MdiIcons.cashSync),
    selectedIcon: Icon(MdiIcons.cashSync),
  ), */
];

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Widget actionButton = HomeFloatingActionButtonWidget(
      summaryController: getIt<SummaryController>(),
    );
    return PaisaAnnotatedRegionWidget(
      child: WillPopScope(
        onWillPop: () async {
          if (context.read<HomeCubit>().state.index == 0) {
            return true;
          }
          context.read<HomeCubit>().setCurrentIndex(0);
          return false;
        },
        child: ScreenTypeLayout.builder(
          mobile: (p0) => HomeMobileWidget(
            floatingActionButton: actionButton,
            destinations: destinations,
          ),
          tablet: (p0) => HomeTabletWidget(
            floatingActionButton: actionButton,
            destinations: destinations,
          ),
          desktop: (p0) => HomeDesktopWidget(
            floatingActionButton: actionButton,
            destinations: destinations,
          ),
        ),
      ),
    );
  }
}

class Destination {
  Destination({
    required this.pageType,
    required this.icon,
    required this.selectedIcon,
  });

  final Icon icon;
  final PageType pageType;
  final Icon selectedIcon;
}
