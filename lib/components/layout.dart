import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/container.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    super.key,
    required this.type,
    required this.date,
    this.calorie,
    this.dish,
    this.period,
    this.subject,
  }) : assert(type == "Meal" || type == "TimeTable");

  final String type;
  final List<String> date;
  final List<String>? calorie;
  final List<String>? dish;
  final List<List<String>>? period;
  final List<List<String>>? subject;

  @override
  Widget build(BuildContext context) {
    final String appBarTitle = type == "Meal" ? "급식" : "시간표";
    final List<Widget> contentWidgets = type == "Meal" 
      ? List.generate(date.length, (index) => 
          Column(
            children: [
              DateContainer(date: date[index]),
              MealContainer(
                calorie: calorie![index],
                dish: dish![index],
              ),
            ]
          )
        )
      : List.generate(date.length, (index) => 
          Column(
            children: [
              DateContainer(date: date[index]),
              TimeTableContainer(
                period: period![index],
                subject: subject![index],
              ),
            ]
          )
        );

    return Scaffold(
      appBar: PageAppBar(title: appBarTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: contentWidgets
          )
        )
      )
    );
  }
}
class TabletLayout extends StatelessWidget {
  const TabletLayout({
    super.key,
    required this.type,
    required this.isTablet,
    required this.date,
    this.calorie,
    this.dish,
    this.period,
    this.subject,
  });

  final String type;
  final bool isTablet;
  final List<String> date;
  final List<String>? calorie;
  final List<String>? dish;
  final List<List<String>>? period;
  final List<List<String>>? subject;

  @override
  Widget build(BuildContext context) {
    double realWidth = MediaQuery.of(context).size.width;
    double safeAreaHorizontalPadding = MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right;
    final screenWidth = realWidth - safeAreaHorizontalPadding;
  
    final String appBarTitle = type == "Meal" ? "급식" : "시간표";
    final double childAspectRatio = type == "Meal" ? (screenWidth / 2) / 271 : (screenWidth / 2) / 371;
    final double height = type == "Meal" ? 222 : 322;

    final List<Widget> contentWidgets = type == "Meal"
      ? List.generate(date.length, (index) => 
          Column(
            children: [
              DateContainer(date: date[index]),
              MealContainer(
                calorie: calorie![index],
                dish: dish![index],
                height: height,
              ),
            ]
          )
        )
      : List.generate(date.length, (index) => 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DateContainer(date: date[index]),
              TimeTableContainer(
                period: period![index],
                subject: subject![index],
                height: height,
              ),
            ]
          )
        );

    return Scaffold(
      appBar: PageAppBar(title: appBarTitle),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: childAspectRatio,
          children: contentWidgets
        )
      )
    );
  }
}