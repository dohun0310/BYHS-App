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
final startOfWeek = DateFormat('yyyyMMdd').format(now.subtract(Duration(days: now.weekday - 1)));
final endOfWeek = DateFormat('yyyyMMdd').format(now.add(Duration(days: DateTime.daysPerWeek - now.weekday)));
final startOfMonth = DateFormat('yyyyMMdd').format(DateTime(now.year, now.month, 1));
final endOfMonth = DateFormat('yyyyMMdd').format(DateTime(now.year, now.month + 1, 0));
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
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        body: homeContent(context),
      ),
    );
  }
}

Widget homeContent(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        widgetTitle(context),
        widgetTodayMeal(context),
        widgetTodayTimeTable(context),
      ],
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

Widget widgetTitle(BuildContext context) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '부용고등학교 $schoolgrade학년 $schoolclass반',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$month월 $day일',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ]
        )
      );
    } 
  );
}

Widget widgetTodayMeal(BuildContext context) {
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
                      return loadingIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
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

Widget widgetTodayTimeTable(BuildContext context) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
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
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(14),
                  child: const Row (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.today,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '시간표',
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
                      ) ,
                    ]
                  ),
                ),
                FutureBuilder<List<String>>(
                  future: getTodayTimeTable(),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loadingIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.data!.length == 1 && snapshot.data![0] == "오늘의 시간표 정보가 없어요.") {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: Text(
                              snapshot.data![0],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var splitText = snapshot.data![index].split(' ');
                          return Container(
                            margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100],
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${splitText[0]} ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: splitText[1],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          );
                        }
                      );
                    }
                  },
                ),
              ],
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
        title: const Text(
          '급식',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Map<String, String>>>(
          future: getMonthMeal(),
          builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
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

class WeekTimeTablePage extends StatelessWidget {
  const WeekTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '시간표',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.entries.map((dateEntry) {
                    if (dateEntry.key == "이번 주 시간표 정보가 없어요.") {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              dateEntry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: Text(
                              dateEntry.value.first,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            dateEntry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          )
                        ),
                        ...dateEntry.value.map((timeTableEntry) {
                          List<String> parts = timeTableEntry.split(' ');
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                ),
                                children: [
                                  TextSpan(
                                    text: '${parts[0]} ',
                                    style: const TextStyle(
                                      color: Colors.grey
                                    )
                                  ),
                                  TextSpan(
                                    text: parts.sublist(1).join(' ')
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
          ],
        ),
      ),
    );
  }
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

Future<List<String>> getTodayTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=$schoolgrade&CLASS_NM=$schoolclass&TI_FROM_YMD=$year$month$day&TI_TO_YMD=$year$month$day'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final timetableElement = document.findAllElements('hisTimetable');

  String extractLetterOrReturnOriginal(String input) {
    RegExp regex = RegExp(r'[A-Z]');
    var match = regex.firstMatch(input);
    return match != null ? match.group(0) ?? '' : input;
  }

  if (timetableElement.isEmpty) {
    return ["오늘의 시간표 정보가 없어요."];
  }

  List<String> timetable = [];
  var rows = timetableElement.first.findAllElements('row').toList();
  for (int i = 0; i < rows.length; i++) {
      var rawSubject = rows[i].findElements('ITRT_CNTNT').first.text;
      var subject = extractLetterOrReturnOriginal(rawSubject); 
      timetable.add('${i + 1} $subject');
  }

  return timetable;
}

Future<Map<String, List<String>>> getWeekTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=$schoolgrade&CLASS_NM=$schoolclass&TI_FROM_YMD=$startOfWeek&TI_TO_YMD=$endOfWeek'),
  );

  final document = xml.XmlDocument.parse(response.body);

  final timetableElement = document.findAllElements('hisTimetable');

  if (timetableElement.isEmpty) {
    return {"이번 주 시간표 정보가 없어요.": ["이번 주 시간표 정보가 없어요."]};
  }

  String extractLetterOrReturnOriginal(String input) {
    RegExp regex = RegExp(r'[A-Z]');
    var match = regex.firstMatch(input);
    return match != null ? match.group(0) ?? '' : input;
  }

  Map<String, List<String>> timetable = {};

  var rows = timetableElement.first.findAllElements('row').toList();
  for (int i = 0; i < rows.length; i++) {
    var rawSubject = rows[i].findElements('ITRT_CNTNT').first.text;
    var subject = extractLetterOrReturnOriginal(rawSubject);
    
    var period = rows[i].findElements('PERIO').first.text;
    var date = rows[i].findElements('ALL_TI_YMD').first.text;
    var formattedDate = '${date.substring(4, 6)}월 ${date.substring(6)}일';

    if (timetable[formattedDate] == null) {
      timetable[formattedDate] = [];
    }
    timetable[formattedDate]?.add('$period $subject');
  }

  return timetable;
}