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
final schoolgrade = '1';
final schoolclass = '1';

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
          widgetTodayMealInkWell(context),
          widgetTodayTimeTableInkWell(context),
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

Widget widgetTodayMealInkWell(BuildContext context) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
        ),
      );
    },
  );
}

Widget widgetTodayTimeTableInkWell(BuildContext context) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WeekTimeTablePage()));
          },
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
        ),
      );
    }
  );
}

class MonthMealPage extends StatelessWidget {
  const MonthMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            FutureBuilder<Map<String, List<String>>>(
              future: getMonthMeal(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, List<String>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: snapshot.data!.entries.map((dateEntry) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dateEntry.key,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            ...dateEntry.value.map((mealContent) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Html(
                                  data: mealContent,
                                  style: {
                                    "body": Style(
                                      fontSize: FontSize(16),
                                      textAlign: TextAlign.center,
                                    ),
                                  },
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class WeekTimeTablePage extends StatelessWidget {
  const WeekTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            FutureBuilder<Map<String, List<String>>>(
              future: getWeekTimeTable(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, List<String>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: snapshot.data!.entries.map((dateEntry) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dateEntry.key,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            ...dateEntry.value.map((mealContent) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Html(
                                  data: mealContent,
                                  style: {
                                    "body": Style(
                                      fontSize: FontSize(16),
                                      textAlign: TextAlign.center,
                                    ),
                                  },
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
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

Future<Map<String, List<String>>> getMonthMeal() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&MLSV_FROM_YMD=$startOfMonth&MLSV_TO_YMD=$endOfMonth')
  );

  final document = xml.XmlDocument.parse(response.body);
  final mealsElement = document.findAllElements('mealServiceDietInfo');

  if (mealsElement.isEmpty) {
    return {"$year년 $month월": ["이번 달 급식 정보가 없어요"]};
  }

  Map<String, List<String>> mealsByDate = {};

  for (var row in mealsElement.first.findAllElements('row')) {
    String date = row.findElements('MLSV_YMD').first.text;
    String formattedDate = '${date.substring(0, 4)}년 ${date.substring(4, 6)}월 ${date.substring(6, 8)}일 급식';
    String mealContent = Html(data: row.findElements('DDISH_NM').first.text).data ?? '';

    if (!mealsByDate.containsKey(formattedDate)) {
      mealsByDate[formattedDate] = [];
    }
    mealsByDate[formattedDate]!.add(mealContent);
  }

  return mealsByDate;
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

Future<Map<String, List<String>>> getWeekTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=$schoolgrade&CLASS_NM=$schoolclass&TI_FROM_YMD=$startOfweek&TI_TO_YMD=$endOfWeek'),
  );

  final document = xml.XmlDocument.parse(response.body);
  final timetableElement = document.findAllElements('hisTimetable');

  if (timetableElement.isEmpty) {
    return {
      "$year년 $month월 $day일 $schoolgrade학년 $schoolclass반 시간표": ["이번 주 시간표 정보가 없어요."]
    };
  }

  String extractLetterOrReturnOriginal(String input) {
    RegExp regex = RegExp(r'[A-Z]');
    var match = regex.firstMatch(input);
    return match != null ? match.group(0) ?? '' : input;
  }

  Map<String, List<String>> weeklyTimetable = {};

  var rows = timetableElement.first.findAllElements('row').toList();
  for (int i = 0; i < rows.length; i++) {
    var rawSubject = rows[i].findElements('ITRT_CNTNT').first.text;
    var subject = extractLetterOrReturnOriginal(rawSubject);
    
    var period = rows[i].findElements('PERIO').first.text;
    var date = rows[i].findElements('ALL_TI_YMD').first.text;
    var formattedDate = '${date.substring(0, 4)}년 ${date.substring(4, 6)}월 ${date.substring(6)}일 $schoolgrade학년 $schoolclass반 시간표';

    if (weeklyTimetable[formattedDate] == null) {
      weeklyTimetable[formattedDate] = [];
    }
    weeklyTimetable[formattedDate]?.add('$period교시: $subject');
  }

  return weeklyTimetable;
}