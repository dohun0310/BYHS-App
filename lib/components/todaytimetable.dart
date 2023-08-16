import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'package:byhsapp/components/error.dart';
import 'package:byhsapp/components/loading.dart';
import 'package:byhsapp/pages/weektimetable/main.dart';
import 'package:byhsapp/pages/setting/user_data.dart';

final key = dotenv.env['API_KEY']!;
final now = DateTime.now();
final year = DateFormat('yyyy').format(now);
final month = DateFormat('MM').format(now);
final day = DateFormat('dd').format(now);

Widget widgetTodayTimeTable(BuildContext context) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
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
                      return const LoadingIndicator();
                    } else if (snapshot.hasError) {
                      return const WidgetError();
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

Future<List<String>> getTodayTimeTable() async {
  final response = await http.get(
    Uri.parse('https://open.neis.go.kr/hub/hisTimetable?KEY=$key&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530575&GRADE=${UserData.instance.schoolgrade}&CLASS_NM=${UserData.instance.schoolclass}&TI_FROM_YMD=$year$month$day&TI_TO_YMD=$year$month$day'),
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