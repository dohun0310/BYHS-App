import 'package:flutter/material.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/container.dart';

final now = DateTime.now();

class MonthMealPage extends StatelessWidget {
  const MonthMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PageAppBar(
        title: "급식"
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  DateContainer(date: "1월 1일 월요일"),
                  MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)"
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 2일 화요일"),
                  MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)"
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 3일 수요일"),
                  MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)"
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 4일 목요일"),
                  MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)"
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 5일 금요일"),
                  MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)"
                  ),
                ],
              ),
              Column(
                children: [
                  DateContainer(date: "1월 7일 월요일"),
                  MealContainer(
                    calorie: "000.0kcal",
                    dish: "셀프스펨무스비\n잔치국수\n<국수고명>매콤애호박채볶음\n돈육고구마강정\n김치무침\n스틱단무지\n<음료>얼박(시원한여름보내세요)"
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