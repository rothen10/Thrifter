// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';

class AppFontChanger extends StatelessWidget {
  const AppFontChanger({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: settings.listenable(keys: [appFontChangerKey]),
      builder: (context, value, child) {
        return ListTile(
          leading: Icon(MdiIcons.formatFont),
          title: Text(context.loc.fontStyle),
          subtitle: Text(context.loc.fontStyleDescription),
          onTap: () {
            const FontPickerPageData().push(context);
          },
        );
      },
    );
  }
}
