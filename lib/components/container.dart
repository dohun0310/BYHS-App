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
    required this.calorie,
    required this.dish,
  });

  final String calorie;
  final String dish;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

class TimeTableContainer extends StatelessWidget {
  const TimeTableContainer({
    super.key,
    required this.period,
    required this.subject,
    required this.border,
  });

  final List period;
  final List subject;
  final double border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).extension<AppExtension>()!.colors.outline,
            width: border
          )
        )
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: period.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: index == period.length - 1 ? 0 : 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).extension<AppExtension>()!.colors.container,
            ),
            child: Row(
              children: [
                Text(
                  period[index],
                  style: ThemeTexts.subheadlineRegular.copyWith(
                    color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  subject[index],
                  style: ThemeTexts.subheadlineRegular.copyWith(
                    color: Theme.of(context).extension<AppExtension>()!.colors.text,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
