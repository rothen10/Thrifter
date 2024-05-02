// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:thrifter/core/common.dart';

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.subtitle,
    this.onTap,
  });

  final IconData? icon;
  final VoidCallback? onTap;
  final String? subtitle;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon == null
          ? null
          : Icon(
              icon,
              color: context.onSurfaceVariant,
            ),
      title: Text(
        title,
        style: TextStyle(
          color: context.onBackground,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: context.onBackground,
              ),
            )
          : null,
      onTap: onTap,
      trailing: trailing,
    );
  }
}
