import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/button.dart';
import 'package:byhsapp/components/textfield.dart';

import 'package:byhsapp/pages/main/main.dart';

class StudentInfoPage extends StatelessWidget {
  const StudentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const PageAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
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
                          CustomTextField(fieldText: "학년"),
                          SizedBox(width: 16),
                          CustomTextField(fieldText: "반"),
                        ] 
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingButton(
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const MainPage())
                        );
                      },
                    ),
                  )
                ],
              )
            ),
          )
        )
      )
    );
  }
}