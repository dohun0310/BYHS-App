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
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    if (isTablet || isLandscape) {
      return TabletLayout(
        isTablet: isTablet,
        date: date,
        calorie: calorie,
        dish: dish,
      );
    } else {
      return MobileLayout(
        date: date,
        calorie: calorie,
        dish: dish,
      );
    }
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    super.key,
    required this.date,
    required this.calorie,
    required this.dish,
  });
  
  final List<String> date;
  final List<String> calorie;
  final List<String> dish;

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

class TabletLayout extends StatelessWidget {
  const TabletLayout({
    super.key,
    required this.isTablet,
    required this.date,
    required this.calorie,
    required this.dish,
  });

  final bool isTablet;
  final List<String> date;
  final List<String> calorie;
  final List<String> dish;

  @override
  Widget build(BuildContext context) {
    double realWidth = MediaQuery.of(context).size.width;
    double safeAreaHorizontalPadding = MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right;
    final screenWidth = realWidth - safeAreaHorizontalPadding;

    return Scaffold(
      appBar: const PageAppBar(title: "급식"),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (screenWidth / 2) / 271,
          children: List.generate(date.length, (index) => 
            Column(
              children: [
                DateContainer(date: date[index]),
                MealContainer(
                  calorie: calorie[index],
                  dish: dish[index],
                  height: 222,
                ),
              ]
            )
          )
        )
      )
    );
  }
}