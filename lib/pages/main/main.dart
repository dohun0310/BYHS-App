import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';
import 'package:byhsapp/components/container.dart';

import 'package:byhsapp/services/fetchmeal.dart';
import 'package:byhsapp/services/fetchtimetable.dart';

import 'package:byhsapp/data/studentdata.dart';

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
  List<String> dish = [];

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
    Meal meal = Meal();
    var mealData = await meal.getMealData();
    setState(() {
      calorie = mealData[0]["details"]["calorie"];
      dish = mealData[0]["details"]["dish"].split("<br/>");
    });
    TimeTable timeTable = TimeTable(grade: grade, classNumber: classNumber);
    var timeTableData = await timeTable.getTimeTableData();
    setState(() {
      for (var item in timeTableData[0]["details"]["period"]) {
        periods.add(item);
      }
      for (var item in timeTableData[0]["details"]["subject"]) {
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
        dish: dish.join('\n'),
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
            child: isLandscape || isTablet
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: buildMealInfoButton()),
                  const SizedBox(width: 16),
                  Expanded(child: buildTimeTableInfoButton())
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