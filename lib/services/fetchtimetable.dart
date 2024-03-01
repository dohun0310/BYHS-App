import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:byhsapp/data/studentdata.dart';
import 'package:byhsapp/data/errorhandlingdata.dart';

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
      return NotFoundData(firstKey: "period", secondKey: "subject").notFoundList();
    } else if (response.statusCode == 500) {
      return ErrorData(firstKey: "period", secondKey: "subject").errorList();
    } else {
      return ErrorData(firstKey: "period", secondKey: "subject").errorList();
    }
  }
}
