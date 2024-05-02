// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/settings/presentation/widgets/setting_option.dart';

class DynamicColorSwitchWidget extends StatelessWidget {
  const DynamicColorSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SettingsOption(
          title: context.loc.dynamicColor,
          trailing: Switch(
            activeColor: context.primary,
            value: settings.get(
              dynamicThemeKey,
              defaultValue: false,
            ),
            onChanged: (value) {
              settings.put(dynamicThemeKey, value);
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
