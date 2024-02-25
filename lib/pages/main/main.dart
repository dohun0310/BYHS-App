import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';
import 'package:byhsapp/components/container.dart';

import 'package:byhsapp/pages/setting/main.dart';
import 'package:byhsapp/pages/monthmeal/main.dart';
import 'package:byhsapp/pages/weektimetable/main.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        rightIcon: Icon(Icons.more_vert),
        destinationPage: SettingPage(),
        date: "1월 1일 월요일",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top:10, left: 16, right: 16),
            child: const Column(
              children: [
                InfoButton(
                  titleIcon: Icons.restaurant,
                  title: "오늘의 급식",
                  destinationPage: MonthMealPage(),
                  child: MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)",
                    border: false
                  ),
                ),
                SizedBox(height: 16),
                InfoButton(
                  titleIcon: Icons.today,
                  title: "시간표",
                  destinationPage: WeekTimeTablePage(),
                  child: TimeTableContainer(
                    period: ["1", "2", "3", "4", "5", "6"],
                    subject: ["문학", "영어I", "수학I", "물리학I", "화학I", "지구과학I"],
                    border: false
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