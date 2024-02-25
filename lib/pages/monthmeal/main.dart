import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/components/error.dart';
import 'package:byhsapp/components/loading.dart';

final key = dotenv.env['API_KEY']!;
final now = DateTime.now();
final startOfMonth = DateFormat('yyyyMMdd').format(DateTime(now.year, now.month, 1));
final endOfMonth = DateFormat('yyyyMMdd').format(DateTime(now.year, now.month + 1, 0));

class MonthMealPage extends StatelessWidget {
  const MonthMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        title: "급식"
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Map<String, String>>>(
          future: getMonthMeal(),
          builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            } else if (snapshot.hasError) {
              return const WidgetError();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data!.map((mealEntry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          mealEntry["meal"]!.split(':').first.trim(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Text(
                              '점심',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${mealEntry["calorie"]!} kcal',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 16, 10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                        ),
                        child: Html(
                          data: mealEntry["meal"]!.split(':').last.trim(),
                          style: {
                            "body": Style(
                              fontSize: FontSize(16.0),
                            ),
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<Map<String, String>>> getMonthMeal() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_FROM_YMD=$startOfMonth&MLSV_TO_YMD=$endOfMonth')
  );

  final document = xml.XmlDocument.parse(response.body);

  final mealsElement = document.findAllElements('mealServiceDietInfo');

  if (mealsElement.isEmpty) {
    return [{"meal": "이번 달 급식 정보가 없어요", "calorie": ""}];
  }

  final meals = mealsElement
      .first
      .findAllElements('row')
      .map((e) {
        String date = e.findElements('MLSV_YMD').first.text;
        String formattedDate = '${date.substring(4, 6)}월 ${date.substring(6, 8)}일';
        String mealContent = e.findElements('DDISH_NM').first.text;
        String calorie = e.findElements('MLSV_FGR').first.text;

        return {
          "meal": "$formattedDate: $mealContent",
          "calorie": calorie
        };
      })
      .toList();

  return meals;
}