import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/container.dart';

import 'package:byhsapp/data/timetabledata.dart';

class WeekTimeTablePage extends StatefulWidget {
  const WeekTimeTablePage({super.key});

  @override
  WeekTimeTablePageState createState() => WeekTimeTablePageState();
}

class WeekTimeTablePageState extends State<WeekTimeTablePage> {
  List<String> date = [];
  List<List<String>> period = [];
  List<List<String>> subject = [];

  @override
  void initState() {
    super.initState();
    getWeekTimeTable();
  }

  void getWeekTimeTable() async {
    final timeTable = TimeTable(dateRange: "Week");
    List<Map<String, dynamic>> weekTimeTables = await timeTable.fetchTimeTable();

    setState(() {
      for (var item in weekTimeTables) {
        date.add(item["date"]);
        List<String> periods = [];
        List<String> subjects = [];
        for (var i in item["details"]["period"]) {
          periods.add(i);
        }
        for (var i in item["details"]["subject"]) {
          subjects.add(i);
        }
        period.add(periods);
        subject.add(subjects);
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
        period: period,
        subject: subject,
      );
    } else {
      return MobileLayout(
        date: date,
        period: period,
        subject: subject,
      );
    }
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    super.key,
    required this.date,
    required this.period,
    required this.subject,
  });

  final List<String> date;
  final List<List<String>> period;
  final List<List<String>> subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "시간표"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(date.length, (index) => 
              Column(
                children: [
                  DateContainer(date: date[index]),
                  TimeTableContainer(
                    period: period[index],
                    subject: subject[index],
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
    required this.period,
    required this.subject,
  });

  final bool isTablet;
  final List<String> date;
  final List<List<String>> period;
  final List<List<String>> subject;

  @override
  Widget build(BuildContext context) {
    double realWidth = MediaQuery.of(context).size.width;
    double safeAreaHorizontalPadding = MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right;
    final screenWidth = realWidth - safeAreaHorizontalPadding;

    return Scaffold(
      appBar: const PageAppBar(title: "시간표"),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (screenWidth / 2) / 371,
          children: List.generate(date.length, (index) => 
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DateContainer(date: date[index]),
                TimeTableContainer(
                  period: period[index],
                  subject: subject[index],
                  height: 322,
                ),
              ]
            )
          )
        )
      )
    );
  }
}