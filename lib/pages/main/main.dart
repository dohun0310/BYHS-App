import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';
import 'package:byhsapp/components/container.dart';

import 'package:byhsapp/data/studentdata.dart';
import 'package:byhsapp/data/mealdata.dart';
import 'package:byhsapp/data/timetabledata.dart';

import 'package:byhsapp/pages/setting/main.dart';
import 'package:byhsapp/pages/monthmeal/main.dart';
import 'package:byhsapp/pages/weektimetable/main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int grade = 0;
  int classNumber = 0;

  String calorie = "";
  String dish = "";

  List<String> periods = [];
  List<String> subjects = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await StudentData.instance.loadStudentData();
    setState(() {
      grade = StudentData.instance.grade!;
      classNumber = StudentData.instance.classNumber!;
    });
    getTodayMeal();
    getTodayTimeTable();
  }

  void getTodayMeal() async {
    final meal = Meal(dateRange: "Today");
    List<Map<String, dynamic>> todayMeals = await meal.fetchMeal();

    setState(() {
      calorie = todayMeals[0]["details"]["calorie"];
      dish = todayMeals[0]["details"]["dish"].replaceAll("<br/>", "\n");
    });
  }

  void getTodayTimeTable() async {
    final timeTable = TimeTable(dateRange: "Today", grade: grade, classNumber: classNumber);
    List<Map<String, dynamic>> todayTimeTables = await timeTable.fetchTimeTable();

    setState(() {
      for (var item in todayTimeTables[0]["details"]["period"]) {
        periods.add(item);
      }
      for (var item in todayTimeTables[0]["details"]["subject"]) {
        subjects.add(item);
      }
    });
  }

  Widget buildMealInfoButton() {
    return InfoButton(
      titleIcon: Icons.restaurant,
      title: "오늘의 급식",
      destinationPage: const MonthMealPage(),
      child: MealContainer(
        calorie: calorie,
        dish: dish,
        border: false
      ),
    );
  }

  Widget buildTimeTableInfoButton() {
    return InfoButton(
      titleIcon: Icons.today,
      title: "오늘의 시간표",
      destinationPage: const WeekTimeTablePage(),
      child: TimeTableContainer(
        period: periods,
        subject: subjects,
        border: false
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      appBar: MainAppBar(
        rightIcon: const Icon(Icons.more_vert),
        destinationPage: const SettingPage(),
        grade: grade,
        classNumber: classNumber,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top:10, left: 16, right: 16),
            child: isLandscape && !isTablet
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildMealInfoButton()
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildTimeTableInfoButton()
                  )
                ],
              )
              : Column(
                children: [
                  buildMealInfoButton(),
                  const SizedBox(height: 16),
                  buildTimeTableInfoButton(),
                ],
              )
          )
        )
      )
    );
  }
}