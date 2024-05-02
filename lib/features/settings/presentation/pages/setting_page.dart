// Flutter imports:
import 'dart:io';

import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrifter/core/enum/theme_mode.dart';
import 'package:thrifter/features/settings/presentation/widgets/choose_calendar_format_widget.dart';
import 'package:thrifter/features/settings/presentation/widgets/choose_theme_mode_widget.dart';
import 'package:thrifter/features/settings/presentation/widgets/true_black_widget_theme.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/enum/calendar_formats.dart';
import 'package:thrifter/core/widgets/paisa_widgets/paisa_divider.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/settings/data/authenticate.dart';
import 'package:thrifter/features/settings/presentation/widgets/app_font_changer.dart';
import 'package:thrifter/features/settings/presentation/widgets/app_language_changer.dart';
import 'package:thrifter/features/settings/presentation/widgets/biometrics_auth_widget.dart';
import 'package:thrifter/features/settings/presentation/widgets/currency_change_widget.dart';
import 'package:thrifter/features/settings/presentation/widgets/setting_option.dart';
import 'package:thrifter/features/settings/presentation/widgets/settings_color_picker_widget.dart';
import 'package:thrifter/features/settings/presentation/widgets/settings_group_card.dart';
import 'package:thrifter/features/settings/presentation/widgets/small_size_fab_widget.dart';
import 'package:thrifter/features/settings/presentation/widgets/version_widget.dart';
import 'package:thrifter/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme =
        ThemeMode.values[settings.get(themeModeKey, defaultValue: 0)];
    final currentFormat = CalendarFormats
        .values[settings.get(calendarFormatKey, defaultValue: 2)];
    return PaisaAnnotatedRegionWidget(
      color: Colors.transparent,
      child: Scaffold(
        appBar: context.materialYouAppBar(
          context.loc.settings,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            SettingsGroup(
              title: context.loc.colorsUI,
              options: [
                const SettingsColorPickerWidget(),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.brightness4,
                  title: context.loc.chooseTheme,
                  subtitle: currentTheme.stringValue,
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width >= 700
                            ? 700
                            : double.infinity,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (_) => ChooseThemeModeWidget(
                        currentTheme: currentTheme,
                      ),
                    );
                  },
                ),
                const PaisaDivider(),
                const JustBlackWidget(),
                const PaisaDivider(),
                const SmallSizeFabWidget(),
              ],
            ),
            SettingsGroup(
              title: context.loc.others,
              options: [
                BiometricAuthWidget(
                  authenticate: getIt<Authenticate>(),
                ),
                const AppLanguageChanger(),
                const PaisaDivider(),
                const CurrencyChangeWidget(),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.calendar,
                  title: context.loc.calendarFormat,
                  subtitle: currentFormat.exampleValue,
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width >= 700
                            ? 700
                            : double.infinity,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (_) => ChooseCalendarFormatWidget(
                        currentFormat: currentFormat,
                      ),
                    );
                  },
                ),
                const PaisaDivider(),
                const AppFontChanger(),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.backupRestore,
                  title: context.loc.backupAndRestoreTitle,
                  subtitle: context.loc.backupAndRestoreSubTitle,
                  onTap: () {
                    const ExportAndImportPageData().push(context);
                  },
                ),
              ],
            ),
            SettingsGroup(
              title: context.loc.socialLinks,
              options: [
                SettingsOption(
                  icon: MdiIcons.glassMugVariant,
                  title: context.loc.supportMe,
                  subtitle: context.loc.supportMeDescription,
                  onTap: () => launchUrl(
                    Uri.parse(buyMeCoffeeUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.star,
                  title: context.loc.appRate,
                  subtitle: context.loc.appRateDesc,
                  onTap: _openPlayStoreAppStoreUrl,
                ),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.github,
                  title: context.loc.github,
                  subtitle: context.loc.githubText,
                  onTap: () => launchUrl(
                    Uri.parse(gitHubUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.send,
                  title: context.loc.telegram,
                  subtitle: context.loc.telegramGroup,
                  onTap: () => launchUrl(
                    Uri.parse(telegramGroupUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const PaisaDivider(),
                SettingsOption(
                  icon: MdiIcons.note,
                  title: context.loc.privacyPolicy,
                  onTap: () => launchUrl(
                    Uri.parse(termsAndConditionsUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const PaisaDivider(),
                const VersionWidget(),
              ],
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.madeWithLoveInIndia,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _openPlayStoreAppStoreUrl() {
  if (Platform.isAndroid || Platform.isIOS) {
    final appId =
        Platform.isAndroid ? 'dev.hemanths.paisa' : 'dev.hemanths.paisa.app';
    final url = Uri.parse(
      Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=$appId'
          : 'https://apps.apple.com/app/id$appId',
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
