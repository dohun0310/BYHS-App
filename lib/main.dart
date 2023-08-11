import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

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
  return FutureBuilder<List<String>>(
    future: getEverything(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return loadingIndicator();
      } else if (snapshot.hasError) {
        return errorWidget();
      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Html(
              data: snapshot.data![index],
            );
          },
        );
      } else {
        return const Text('No Data');
      }
    },
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

Future<List<String>> getEverything() async {
  final meals = await getTodayMeal();
  final timetable = await getTimeTable();
  return meals + timetable;
}

Future<List<String>> getTodayMeal() async {
  final now = DateTime.now();
  final today = DateFormat('yyyyMMdd').format(now);

  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_YMD=$today'),
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
  final now = DateTime.now();
  final month = DateFormat('yyyyMM').format(now);

  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_YMD=$month'),
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

Future<List<String>> getTimeTable() async {
  final now = DateTime.now();
  final month = DateFormat('yyyyMM').format(now);

  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&ALL_TI_YMD=$month&GRADE=2&CLASS_NM=2'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final timetableElement = document.findAllElements('hisTimetable');

  if (timetableElement.isEmpty) {
    return ["이번 주 시간표 정보가 없어요."];
  }

  final timetable = timetableElement
      .first
      .findAllElements('row')
      .map((e) => e.findElements('ITRT_CNTNT').first.text)
      .toList();

  return timetable;
}