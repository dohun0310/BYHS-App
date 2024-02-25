import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';

import 'package:byhsapp/pages/studentinfo/main.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(leading: false),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "반가워요!\n부용고등학교 앱을 시작해볼까요?",
                style: ThemeTexts.title2Emphasized.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.text
                ),
              ),
              FloatingButton(
                title: "시작하기",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentInfoPage()),
                  );
                },
                extended: true,
              )
            ],
          )
        )
      )
    );
  }
}