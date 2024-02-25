import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Text(
        date,
        style: ThemeTexts.calloutEmphasized.copyWith(
          color: Theme.of(context).extension<AppExtension>()!.colors.text,
        ),
      )
    );
  }
}