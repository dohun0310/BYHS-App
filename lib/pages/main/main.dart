import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';
import 'package:byhsapp/components/container.dart';

import 'package:byhsapp/data/todaymeal.dart';

import 'package:byhsapp/pages/setting/main.dart';
import 'package:byhsapp/pages/monthmeal/main.dart';
import 'package:byhsapp/pages/weektimetable/main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  String calorie = "";
  String dish = "";

  @override
  void initState() {
    super.initState();
    getTodayMeal();
  }

  void getTodayMeal() async {
    fetchTodayMeal().then((value) {
      setState(() {
        calorie = value[0]["details"]["calorie"];
        dish = value[0]["details"]["dish"];
      });
    });
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        rightIcon: Icon(Icons.more_vert),
        destinationPage: SettingPage(),
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
                  child: MealContainer(
                    calorie: calorie,
                    dish: dish,
                    border: false
                  ),
                ),
                const SizedBox(height: 16),
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