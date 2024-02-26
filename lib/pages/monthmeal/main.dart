import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/container.dart';

import 'package:byhsapp/data/mealdata.dart';

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
    return Scaffold(
      appBar: const PageAppBar(title: "급식"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(date.length, (index) => 
              Column(
                children: [
                  DateContainer(date: date[index]),
                  MealContainer(
                    calorie: calorie[index],
                    dish: dish[index],
                  ),
                ]
              )
            )
          )
        )
      )
    );
  }
}