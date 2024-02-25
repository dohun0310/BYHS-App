import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';

import 'package:byhsapp/pages/monthmeal/main.dart';
import 'package:byhsapp/pages/weektimetable/main.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        rightIcon: Icon(Icons.more_vert),
        title: "부용고등학교 2학년 2반",
        date: "1월 1일 월요일",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top:10, left: 16, right: 16),
            child: Column(
              children: [
                InfoButton(
                  titleIcon: Icons.restaurant,
                  title: "오늘의 급식",
                  destinationPage: const MonthMealPage(),
                  child: Container(
                    padding: const EdgeInsets.all(14),
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
                              "000.0kcal",
                              style: ThemeTexts.subheadlineRegular.copyWith(
                                color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)",
                          style: ThemeTexts.subheadlineRegular.copyWith(
                            color: Theme.of(context).extension<AppExtension>()!.colors.text,
                          ),
                        )
                      ]
                    )
                  ),
                ),
                const SizedBox(height: 16),
                InfoButton(
                  titleIcon: Icons.today,
                  title: "시간표",
                  destinationPage: const WeekTimeTablePage(),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "1",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "국어",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "2",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "수학",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child:Row(
                            children: [
                              Text(
                                "3",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "영어",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "4",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "화학I",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "5",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "물리I",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "6",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "지구과학I",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).extension<AppExtension>()!.colors.container,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "7",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                                )
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "생명과학I",
                                style: ThemeTexts.subheadlineRegular.copyWith(
                                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                                )
                              ),
                            ]
                          )
                        ),
                      ]
                    )
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}