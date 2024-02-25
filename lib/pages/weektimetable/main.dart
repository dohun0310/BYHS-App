import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/container.dart';

class WeekTimeTablePage extends StatelessWidget {
  const WeekTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PageAppBar(
        title: "시간표"
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  DateContainer(date: "1월 1일 월요일"),
                  TimeTableContainer(
                    period: ["1", "2", "3", "4", "5", "6"],
                    subject: ["문학", "영어I", "수학I", "물리학I", "화학I", "지구과학I"]
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 1일 월요일"),
                  TimeTableContainer(
                    period: ["1", "2", "3", "4", "5", "6"],
                    subject: ["문학", "영어I", "수학I", "물리학I", "화학I", "지구과학I"]
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 1일 월요일"),
                  TimeTableContainer(
                    period: ["1", "2", "3", "4", "5", "6"],
                    subject: ["문학", "영어I", "수학I", "물리학I", "화학I", "지구과학I"]
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 1일 월요일"),
                  TimeTableContainer(
                    period: ["1", "2", "3", "4", "5", "6"],
                    subject: ["문학", "영어I", "수학I", "물리학I", "화학I", "지구과학I"]
                  ),
                ],
              ),
            ],
          )
        )
      )
    );
  }
}