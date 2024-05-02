// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/settings/presentation/pages/app_language_changer_page.dart';

class AppLanguageChanger extends StatelessWidget {
  const AppLanguageChanger({super.key});

  @override
  Widget build(BuildContext context) {
    final String code = settings.get(appLanguageKey, defaultValue: 'en');
    return ListTile(
      leading: Icon(
        MdiIcons.translate,
        color: context.onSurfaceVariant,
      ),
      onTap: () {
        AppLanguageChangerPageData(currentLanguage: code).push(context);
      },
      title: Text(context.loc.appLanguage),
      subtitle: Text(Languages.languages
          .firstWhere((element) => element.code == code)
          .value),
    );
  }
}
