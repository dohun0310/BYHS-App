import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'package:byhsapp/components/error.dart';
import 'package:byhsapp/components/loading.dart';
import 'package:byhsapp/pages/monthmeal/main.dart';

final key = dotenv.env['API_KEY']!;
final now = DateTime.now();
final year = DateFormat('yyyy').format(now);
final month = DateFormat('MM').format(now);
final day = DateFormat('dd').format(now);

Widget widgetTodayMeal(BuildContext context) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MonthMealPage()));
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(14),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '오늘의 급식',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Spacer(),
                      Text(
                        '더보기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )
                      )
                    ],
                  ),
                ),
                FutureBuilder<List<Map<String, String>>>(
                  future: getTodayMeal(),
                  builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingIndicator();
                    } else if (snapshot.hasError) {
                      return const WidgetError();
                    } else {
                      var lunchMeal = snapshot.data!.first;
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 14),
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
                                  '${lunchMeal["calorie"]} kcal',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            child: Html(
                              data: '${lunchMeal["meal"]}',
                              style: {
                                "body": Style(
                                  fontSize: FontSize(14.0),
                                )
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<List<Map<String, String>>> getTodayMeal() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_FROM_YMD=$year$month$day&MLSV_TO_YMD=$year$month$day'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final mealsElement = document.findAllElements('mealServiceDietInfo');
  
  if (mealsElement.isEmpty) {
    return [{"meal": "오늘의 급식 정보가 없어요.", "calorie": ""}];
  }

  final meals = mealsElement
      .first
      .findAllElements('row')
      .map((e) => {
        "meal": e.findElements('DDISH_NM').first.text,
        "calorie": e.findElements('MLSV_FGR').first.text
      })
      .toList();

  return meals;
}