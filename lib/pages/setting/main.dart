import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';

import 'package:byhsapp/data/studentdata.dart';

import 'package:byhsapp/pages/studentinfo/main.dart';
import 'package:byhsapp/pages/info/main.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "설정"),
      body: SafeArea(
        child: Column(
          children: [
            ListButton(
              title: "학급 변경",
              value: FutureBuilder(
                future: StudentData.instance.loadStudentData(),
                builder: (context, snapshot) {
                  return Text(
                    "${StudentData.instance.grade}학년 ${StudentData.instance.classNumber}반",
                    style: ThemeTexts.calloutRegular.copyWith(
                      color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                    ),
                  );
                }
              ),
              destinationPage: const StudentInfoPage(),
            ),
            const ListButton(
              title: "정보",
              destinationPage: InfoPage(),
            ),
          ],
        ),
      )
    );
  }
}