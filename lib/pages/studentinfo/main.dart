import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';
import 'package:byhsapp/components/textfield.dart';

import 'package:byhsapp/pages/main/main.dart';


class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  StudentInfoPageState createState() => StudentInfoPageState();
}

class StudentInfoPageState extends State<StudentInfoPage> {
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboardingComplete", true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const PageAppBar(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "학년과 반을 입력해주세요.",
                      style: ThemeTexts.title2Emphasized.copyWith(
                        color: Theme.of(context).extension<AppExtension>()!.colors.text
                      ),
                    ),
                    const SizedBox(height: 36),
                    const Row(
                      children: [
                        CustomTextField(
                          fieldText: "학년",
                          minVal: 1,
                          maxVal: 3
                        ),
                        SizedBox(width: 16),
                        CustomTextField(
                          fieldText: "반",
                          minVal: 1,
                          maxVal: 12
                        ),
                      ] 
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingButton(
                    icon: Icons.arrow_forward,
                    onPressed: () async {
                      await completeOnboarding();

                      if (mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const MainPage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                  )
                )
              ],
            )
          ),
        )
      )
    );
  }
}