import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import 'package:byhsapp/components/error.dart';
import 'package:byhsapp/components/loading.dart';
import 'package:byhsapp/pages/setting/user_data.dart';

final key = dotenv.env['API_KEY']!;
final now = DateTime.now();
final startOfWeek = DateFormat('yyyyMMdd').format(now.subtract(Duration(days: now.weekday - 1)));
final endOfWeek = DateFormat('yyyyMMdd').format(now.add(Duration(days: DateTime.daysPerWeek - now.weekday)));

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
        backgroundColor: const Color(0xFFFFFFFF),
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
                  return const LoadingIndicator();
                } else if (snapshot.hasError) {
                  return const WidgetError();
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
                                  fontSize: 20),
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
                                      fontSize: 16, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '${parts[0]} ',
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                    TextSpan(
                                      text: parts.sublist(1).join(' '),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[300]!),
                              ),
                            )
                          )
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

Future<Map<String, List<String>>> getWeekTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=${UserData.instance.schoolgrade}&CLASS_NM=${UserData.instance.schoolclass}&TI_FROM_YMD=$startOfWeek&TI_TO_YMD=$endOfWeek'),
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