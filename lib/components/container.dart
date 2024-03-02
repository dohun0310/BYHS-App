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

class TitleContainer extends StatelessWidget {
  const TitleContainer({
    super.key,
    required this.titleIcon,
    required this.title,
    this.text = "더보기"
  });

  final IconData titleIcon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              titleIcon,
              size: 20,
              color: Theme.of(context).extension<AppExtension>()!.colors.text,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: ThemeTexts.subheadlineEmphasized.copyWith(
                color: Theme.of(context).extension<AppExtension>()!.colors.text,
              ),
            ),
          ],
        ),
        Text(
          text,
          style: ThemeTexts.subheadlineRegular.copyWith(
            color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
          ),
        )
      ],
    );
  }
}

class MealContainer extends StatelessWidget {
  const MealContainer({
    super.key,
    required this.calorie,
    required this.dish,
    this.height,
    this.border = true,
  });

  final String calorie;
  final String dish;
  final double? height;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: border ? Theme.of(context).extension<AppExtension>()!.colors.outline : Colors.transparent,
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
    this.height,
    this.border = true,
    this.padding = true,
  });

  final List period;
  final List subject;
  final double? height;
  final bool border;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ? const EdgeInsets.all(14) : null,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: border ? Theme.of(context).extension<AppExtension>()!.colors.outline : Colors.transparent,
            width: 1
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
            )
          );
        }
      )
    );
  }
}

class LargeWidgetContainer extends StatelessWidget {
  const LargeWidgetContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 338,
      height: 354,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppExtension>()!.colors.background,
      ),
      child: child,
    );
  }
}