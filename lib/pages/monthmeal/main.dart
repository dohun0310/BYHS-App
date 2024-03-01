import 'package:flutter/material.dart';

import 'package:byhsapp/components/layout.dart';

import 'package:byhsapp/services/fetchmeal.dart';

class MonthMealPage extends StatefulWidget {
  const MonthMealPage({super.key});

  @override
  MonthMealPageState createState() => MonthMealPageState();
}

class MonthMealPageState extends State<MonthMealPage> {
  List<String> date = [];
  List<String> calorie = [];
  List<String> dish = [];

  @override
  void initState() {
    super.initState();
    getMonthMeal();
  }

  void getMonthMeal() async {
    final Meal meal = Meal(dateRange: "Month");
    List<Map<String, dynamic>> monthMeals = await meal.fetchMeal();

    setState(() {
      for (var item in monthMeals) {
        date.add(item["date"]);
        calorie.add(item["details"]["calorie"]);
        dish.add(item["details"]["dish"].replaceAll("<br/>", "\n"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    if (isTablet || isLandscape) {
      return TabletLayout(
        type: "Meal",
        isTablet: isTablet,
        date: date,
        calorie: calorie,
        dish: dish,
      );
    } else {
      return MobileLayout(
        type: "Meal",
        date: date,
        calorie: calorie,
        dish: dish,
      );
    }
  }
}