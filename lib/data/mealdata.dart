import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:byhsapp/data/errordata.dart';

class Meal {
  Meal({
    required this.dateRange,
  });

  final String dateRange;

  Future<List<Map<String, dynamic>>> fetchMeal() async {
    final url = Uri.parse("${dotenv.get("API_URL")}/get${dateRange}Meal");
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
}