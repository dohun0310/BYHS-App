import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:byhsapp/data/studentdata.dart';
import 'package:byhsapp/data/errorhandlingdata.dart';

class TimeTable {
  TimeTable({
    this.grade,
    this.classNumber,
  });

  final int? grade;
  final int? classNumber;

  static const String timeTableKey = "cachedTimeTable";
  static const String timeTableExpiryKey = "cachedTimeTableExpiry";

  Future<List<Map<String, dynamic>>> fetchTimeTable() async {
    final url = Uri.parse("${dotenv.get("API_URL")}/getWeekTimeTable/${grade ?? StudentData.instance.grade}/${classNumber ?? StudentData.instance.classNumber}");
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

  Future<void> cacheTimeTableData(dynamic timeTableData) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTerm = DateTime.now().add(const Duration(hours: 3));
    await prefs.setString(timeTableKey, json.encode(timeTableData));
    await prefs.setInt(timeTableExpiryKey, expiryTerm.millisecondsSinceEpoch);
  }

  Future<void> clearTimeTableData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(timeTableKey);
    await prefs.remove(timeTableExpiryKey);
  }

  Future<dynamic> getTimeTableData() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTimestamp = prefs.getInt(timeTableExpiryKey);
    final now = DateTime.now();

    if (expiryTimestamp != null && now.millisecondsSinceEpoch < expiryTimestamp) {
      final cachedData = prefs.getString(timeTableKey);
      return json.decode(cachedData!);
    } else {
      final timeTableData = await fetchTimeTable();
      await cacheTimeTableData(timeTableData);
      return timeTableData;
    }
  }
}