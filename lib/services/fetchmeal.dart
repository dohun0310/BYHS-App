import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:byhsapp/data/errorhandlingdata.dart';

class Meal {
  static const String mealKey = "cachedMeal";
  static const String mealExpiryKey = "cachedMealExpiry";

  Future<List<Map<String, dynamic>>> fetchMeal() async {
    final url = Uri.parse("${dotenv.get("API_URL")}/getMonthMeal");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> meals = [];

      for (var item in data) {
        Map<String, dynamic> mealDetails = {
          "date": item["RESULT_DATA"]["date"],
          "details": {
            "calorie": item["RESULT_DATA"]["calorie"][0],
            "dish": item["RESULT_DATA"]["dish"][0],
          }
        };
        meals.add(mealDetails);
      }

      return meals;
    } else if (response.statusCode == 404) {
      return NotFoundData(firstKey: "calorie", secondKey: "dish").notFoundList();
    } else if (response.statusCode == 500) {
      return ErrorData(firstKey: "calorie", secondKey: "dish").errorList();
    } else {
      return ErrorData(firstKey: "calorie", secondKey: "dish").errorList();
    }
  }

  Future<void> cacheMealData(dynamic mealData) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTerm = DateTime.now().add(const Duration(hours: 3));
    await prefs.setString(mealKey, json.encode(mealData));
    await prefs.setInt(mealExpiryKey, expiryTerm.millisecondsSinceEpoch);
  }

  Future<dynamic> getMealData() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTimestamp = prefs.getInt(mealExpiryKey);
    final now = DateTime.now();

    if (expiryTimestamp != null && now.millisecondsSinceEpoch < expiryTimestamp) {
      final cachedData = prefs.getString(mealKey);
      return json.decode(cachedData!);
    } else {
      final mealData = await fetchMeal();
      await cacheMealData(mealData);
      return mealData;
    }
  }
}