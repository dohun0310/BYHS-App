import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Map<String, dynamic>>> fetchTodayMeal() async {
  final url = Uri.parse("${dotenv.get("API_URL")}/getTodayMeal");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Map<String, dynamic>> todayMeals = [];

    for (var item in data) {
      Map<String, dynamic> mealDetails = {
        "date": item["RESULT_DATA"]["date"],
        "details": {
          "calorie": item["RESULT_DATA"]["calorie"][0],
          "dish": item["RESULT_DATA"]["dish"][0],
        }
      };
      todayMeals.add(mealDetails);
    }

    return todayMeals;
  } else {
    throw Exception("Failed to load month meal");
  }
}