import 'package:flutter/material.dart';

import 'package:byhsapp/components/layout.dart';

import 'package:byhsapp/services/fetchtimetable.dart';

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
        type: "TimeTable",
        date: date,
        period: period,
        subject: subject,
      );
    } else {
      return MobileLayout(
        type: "TimeTable",
        date: date,
        period: period,
        subject: subject,
      );
    }
  }
}