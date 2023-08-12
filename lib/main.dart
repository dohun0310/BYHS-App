import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'dart:core';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

final key = dotenv.env['API_KEY']!;
final now = DateTime.now();
final startOfweek = now.subtract(Duration(days: now.weekday - 1));
final endOfWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
final startOfMonth = DateTime(now.year, now.month, 1);
final endOfMonth = DateTime(now.year, now.month + 1, 0);
final year = DateFormat('yyyy').format(now);
final month = DateFormat('MM').format(now);
final day = DateFormat('dd').format(now);
final schoolgrade = '2';
final schoolclass = '2';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: homeContent(context),
      ),
    );
  }
}

Widget homeContent(BuildContext context) {
  return SafeArea(
    child: Center(
      child: Column(
        children: [
          widgetTodayMealInkWell(),
          widgetTodayTimeTableInkWell(),
        ],
      ),
    ),
  );
}

Widget loadingIndicator() {
  return const CircularProgressIndicator();
}

Widget errorWidget() {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          SizedBox(height: 8),
          Text(
            "내용을 불러오는데 문제가 발생했어요.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "인터넷 연결에 문제가 있거나\n앱 또는 나이스 서버에 문제가 있을 수 있어요.\n",
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "인터넷 연결에 문제가 없다면 개발자에게 문의해주세요",
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

Widget widgetTodayMealInkWell() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                '$year년 $month월 $day일 급식',
                style: 
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<String>>(
                future: getTodayMeal(),
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Html(
                      data: '''
                        <div style="text-align: center; font-size: 16px; font-weight: 500;">
                          ${snapshot.data!.join('<br />')}
                        </div>
                      '''
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    )
  );
}

Widget widgetTodayTimeTableInkWell() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                '$year년 $month월 $day일 $schoolgrade학년 $schoolclass반 시간표',
                style: 
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<String>>(
                future: getTodayTimeTable(),
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Html(
                      data: '''
                        <div style="text-align: center; font-size: 16px; font-weight: 500;">
                          ${snapshot.data!.join('<br />')}
                        </div>
                      '''
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    )
  );
}

Future<List<String>> getTodayMeal() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_FROM_YMD=$year$month$day&MLSV_TO_YMD=$year$month$day'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final mealsElement = document.findAllElements('mealServiceDietInfo');
  
  if (mealsElement.isEmpty) {
    return ["오늘의 급식 정보가 없어요."];
  }

  final meals = mealsElement
      .first
      .findAllElements('row')
      .map((e) => e.findElements('DDISH_NM').first.text)
      .toList();

  return meals;
}

Future<List<String>> getMonthMeal() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_FROM_YMD=$startOfMonth&MLSV_TO_YMD=$endOfMonth'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final mealsElement = document.findAllElements('mealServiceDietInfo');
  
  if (mealsElement.isEmpty) {
    return ["이번 주 급식 정보가 없어요"];
  }

  final meals = mealsElement
      .first
      .findAllElements('row')
      .map((e) => e.findElements('DDISH_NM').first.text)
      .toList();

  return meals;
}

Future<List<String>> getTodayTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=$schoolgrade&CLASS_NM=$schoolclass&TI_FROM_YMD=$year$month$day&TI_TO_YMD=$year$month$day'),
  );

  final document = xml.XmlDocument.parse(response.body);
  final timetableElement = document.findAllElements('hisTimetable');

  if (timetableElement.isEmpty) {
    return ["오늘의 시간표 정보가 없어요."];
  }

  String extractLetterOrReturnOriginal(String input) {
    RegExp regex = RegExp(r'[A-Z]');
    var match = regex.firstMatch(input);
    return match != null ? match.group(0) ?? '' : input;
  }

  List<String> timetable = [];
  var rows = timetableElement.first.findAllElements('row').toList();
  for (int i = 0; i < rows.length; i++) {
      var rawSubject = rows[i].findElements('ITRT_CNTNT').first.text;
      var subject = extractLetterOrReturnOriginal(rawSubject); 
      timetable.add('${i + 1}교시: $subject');
  }

  return timetable;
}


Future<List<String>> getWeekTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=$schoolgrade&CLASS_NM=$schoolclass&TI_FROM_YMD=$startOfweek&TI_TO_YMD=$endOfWeek'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final timetableElement = document.findAllElements('hisTimetable');

  if (timetableElement.isEmpty) {
    return ["이번 주 시간표 정보가 없어요."];
  }

  String extractLetterOrReturnOriginal(String input) {
    RegExp regex = RegExp(r'[A-Z]');
    var match = regex.firstMatch(input);
    return match != null ? match.group(0) ?? '' : input;
  }

  List<String> timetable = [];
  var rows = timetableElement.first.findAllElements('row').toList();
  for (int i = 0; i < rows.length; i++) {
      var rawSubject = rows[i].findElements('ITRT_CNTNT').first.text;
      var subject = extractLetterOrReturnOriginal(rawSubject); 
      timetable.add('${i + 1}교시: $subject');
  }

  return timetable;
}