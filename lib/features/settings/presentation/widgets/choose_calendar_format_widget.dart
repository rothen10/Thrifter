// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/adapters.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/core/enum/calendar_formats.dart';
import 'package:thrifter/main.dart';

class ChooseCalendarFormatWidget extends StatefulWidget {
  const ChooseCalendarFormatWidget({
    super.key,
    this.currentFormat,
  });

  final CalendarFormats? currentFormat;

  @override
  ChooseCalendarFormatWidgetState createState() =>
      ChooseCalendarFormatWidgetState();
}

class ChooseCalendarFormatWidgetState
    extends State<ChooseCalendarFormatWidget> {
  late CalendarFormats currentIndex =
      widget.currentFormat ?? CalendarFormats.mmddyyyy;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              context.loc.calendarFormat,
              style: context.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ...CalendarFormats.values.map(
                  (e) => RadioListTile<CalendarFormats>(
                    value: e,
                    activeColor: context.primary,
                    groupValue: currentIndex,
                    onChanged: (CalendarFormats? value) {
                      currentIndex = value!;
                      setState(() {});
                    },
                    title: Text(
                      e.exampleValue,
                      style: TextStyle(
                        color: context.onSurface,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    context.loc.cancel,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => getIt
                      .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                      .put(calendarFormatKey, currentIndex.index)
                      .then((value) => Navigator.pop(context)),
                  child: Text(context.loc.ok),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
