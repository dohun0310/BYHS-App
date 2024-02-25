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
      alignment: Alignment.centerLeft,
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

class MealContainer extends StatelessWidget {
  const MealContainer({
    super.key,
    required this.date,
    required this.calorie,
    required this.dish,
  });

  final String date;
  final String calorie;
  final String dish;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateContainer(date: date),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).extension<AppExtension>()!.colors.outline,
                width: 1
              )
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "점심",
                    style: ThemeTexts.subheadlineRegular.copyWith(
                      color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                    ),
                  ),
                  Text(
                    calorie,
                    style: ThemeTexts.subheadlineRegular.copyWith(
                      color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                    ),
                  )
                ]
              ),
              const SizedBox(height: 8),
              Text(
                dish,
                style: ThemeTexts.subheadlineRegular.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                ),
              )
            ],
          )
        ),
      ]
    );
  }
}