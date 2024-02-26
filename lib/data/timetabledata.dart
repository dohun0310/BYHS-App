import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:byhsapp/data/studentdata.dart';
import 'package:byhsapp/data/errordata.dart';

class TimeTable {
  TimeTable({
    required this.dateRange,
    this.grade,
    this.classNumber,
  });

  final String dateRange;
  final int? grade;
  final int? classNumber;

  Future<List<Map<String, dynamic>>> fetchTimeTable() async {
    final url = Uri.parse("${dotenv.get("API_URL")}/get${dateRange}TimeTable/${grade ?? StudentData.instance.grade}/${classNumber ?? StudentData.instance.classNumber}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> timeTables = [];

      for (var item in data) {
        Map<String, dynamic> timeTableDetails = {
          "date": item["RESULT_DATA"]["date"],
          "details": {
            "period": item["RESULT_DATA"]["period"],
            "subject": item["RESULT_DATA"]["subject"],
          }
        };
        timeTables.add(timeTableDetails);
      }

      return timeTables;
    } else if (response.statusCode == 404) {
      return notFoundTimeList;
    } else if (response.statusCode == 500) {
      return errorTimeList;
    } else {
      return errorTimeList;
    }
  }
}
