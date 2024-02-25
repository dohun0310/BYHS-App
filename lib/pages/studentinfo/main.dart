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
  int? grade;
  int? classNumber;

  bool get isButtonEnabled => grade != null && classNumber != null;

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (grade != null) await prefs.setInt("grade", grade!);
    if (classNumber != null) await prefs.setInt("classNumber", classNumber!);
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
                    Row(
                      children: [
                        CustomTextField(
                          fieldText: "학년",
                          minVal: 1,
                          maxVal: 3,
                          onTextChanged: (value) {
                            setState(() {
                              grade = int.tryParse(value);
                            });
                          }
                        ),
                        const SizedBox(width: 16),
                        CustomTextField(
                          fieldText: "반",
                          minVal: 1,
                          maxVal: 12,
                          onTextChanged: (value) {
                            setState(() {
                              classNumber = int.tryParse(value);
                            });
                          },
                        ),
                      ] 
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    opacity: isButtonEnabled ? 1.0 : 0.4,
                    child: FloatingButton(
                      icon: Icons.arrow_forward,
                      onPressed: isButtonEnabled ? () async {
                        await saveData();
                        Navigator.of(mounted as BuildContext).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (mounted) => const MainPage()),
                          (Route<dynamic> route) => false,
                        );
                      } : null,
                    )
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